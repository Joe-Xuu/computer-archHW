; Matrix Multiply Portion of the Assembly Code
; Name: Xu Haoran  Student ID: 72344187

multiply_matrices:
.LFB7:
    .cfi_startproc
    endbr64
    pushq   %rbp                        ; q:suffix to show operand size(8-Byte). push rbp on to stack
    .cfi_def_cfa_offset 16
    .cfi_offset 6, -16
    movq    %rsp, %rbp                  ; move rsp to rbp, set up stack frame
    .cfi_def_cfa_register 6

; loop control
    ; int i = 0
    movl    $0, -12(%rbp)               ; i = 0
    jmp     .L7                         ; jump to outer loop condition check L7

.L12: ; loop of i
    ; int j = 0
    movl    $0, -8(%rbp)                ; j = 0
    jmp     .L8                         ; jump to middle loop 

.L11: ; loop of j
    ; int k = 0
    movl    $0, -4(%rbp)                ; k = 0
    jmp     .L9                         ; jump to inner loop

.L10: ; loop of k
    ; load 3 matrices to xmm registers
    ; ----------- load C[i][j] to xmm1 -----------
    ; xmm register: 128-bit for floating point operations
    ; purpose: load C[i][j] to xmm1 for addition (address calculation: addr = &C + ((i * SIZE) + j) * 8)
    ; we use SIZE = 100 as the example
    movl    -8(%rbp), %eax              ; eax = j
    movslq  %eax, %rcx                  ; rcx = (long)j
    movl    -12(%rbp), %eax             ; eax = i
    movslq  %eax, %rdx                  ; rdx = (long)i

    movq    %rdx, %rax                  ; rax = i
    salq    $2, %rax                    ; rax = i * 4 sal:Left shift destination by 2​ bits (*4)
    addq    %rdx, %rax                  ; rax = i * 4 + i = i*5

    ; 0(,%rax,4) => 0 + rax * 4 -> i * 5 * 4 = i * 20 optimization to avoid real multiply instructions like imul or shl
    leaq    0(,%rax,4), %rdx            ; rdx = i * 20 leaq: Load effective address of source into destination
    addq    %rdx, %rax                  ; rax = i * 25 (20 + 5)
    salq    $2, %rax                    ; rax = i * 100 (25 * 4) shift left
    addq    %rcx, %rax                  ; rax = i * 100 + j (rcx = j)
    
    ; Calculate the byte offset of the target element relative to the base address (sizeof(double)=8 => * 8)
    leaq    0(,%rax,8), %rdx            ; rdx = offset of C[i][j] in bytes

    ; use relative addressing to get the address of C[0][0] (global variable)
    leaq    C(%rip), %rax               ; rax = &C[0][0]
    movsd   (%rdx,%rax), %xmm1          ; xmm1 = C[i][j] (rdx,rax)

    ; ----------- load A[i][k] to xmm2 -----------
    ; same as above, load A[i][k] to xmm2 for multiplication
    movl    -4(%rbp), %eax              ; eax = k
    movslq  %eax, %rcx                  ; rcx = (long)k
    movl    -12(%rbp), %eax             ; eax = i
    movslq  %eax, %rdx                  ; rdx = (long)i
    movq    %rdx, %rax
    salq    $2, %rax                    ; rax = i * 4
    addq    %rdx, %rax                  ; rax = i * 5
    leaq    0(,%rax,4), %rdx            ; rdx = i * 20
    addq    %rdx, %rax                  ; rax = i * 25
    salq    $2, %rax                    ; rax = i * 100
    addq    %rcx, %rax                  ; rax = i * 100 + k
    leaq    0(,%rax,8), %rdx            ; rdx = offset of A[i][k]
    leaq    A(%rip), %rax               ; rax = &A[0][0]
    movsd   (%rdx,%rax), %xmm2          ; xmm2 = A[i][k]

    ; ----------- load B[k][j] to xmm0 -----------
    ; same as above, load B[k][j] to xmm0
    movl    -8(%rbp), %eax              ; eax = j
    movslq  %eax, %rcx                  ; rcx = (long)j
    movl    -4(%rbp), %eax              ; eax = k
    movslq  %eax, %rdx                  ; rdx = (long)k
    movq    %rdx, %rax
    salq    $2, %rax                    ; rax = k * 4
    addq    %rdx, %rax                  ; rax = k * 5
    leaq    0(,%rax,4), %rdx            ; rdx = k * 20
    addq    %rdx, %rax                  ; rax = k * 25
    salq    $2, %rax                    ; rax = k * 100
    addq    %rcx, %rax                  ; rax = k * 100 + j
    leaq    0(,%rax,8), %rdx            ; rdx = offset of B[k][j]
    leaq    B(%rip), %rax               ; rax = &B[0][0]
    movsd   (%rdx,%rax), %xmm0          ; xmm0 = B[k][j]

    ; ----------- arithmetics -----------
    mulsd   %xmm2, %xmm0                ; xmm0 = A[i][k] * B[k][j]
    addsd   %xmm1, %xmm0                ; xmm0 = xmm0 + C[i][j]

    ; ----------- write back to C[i][j] -----------
    movl    -8(%rbp), %eax              ; eax = j
    movslq  %eax, %rcx                  ; rcx = j
    movl    -12(%rbp), %eax             ; eax = i
    movslq  %eax, %rdx                  ; rdx = i
    movq    %rdx, %rax
    salq    $2, %rax                    ; i * 4
    addq    %rdx, %rax                  ; i * 5
    leaq    0(,%rax,4), %rdx            ; i * 20
    addq    %rdx, %rax                  ; i * 25
    salq    $2, %rax                    ; i * 100
    addq    %rcx, %rax                  ; i * 100 + j
    leaq    0(,%rax,8), %rdx            ; rdx = offset of C[i][j]
    leaq    C(%rip), %rax               ; rax = &C[0][0]
    movsd   %xmm0, (%rdx,%rax)          ; C[i][j] = xmm0

    ; k++
    addl    $1, -4(%rbp)

; loop condition check
.L9: ;inner loop 
    cmpl    $99, -4(%rbp)               ; if (k <= 99)
    jle     .L10                        ;    repeat inner loop (L10)

    ; j++
    addl    $1, -8(%rbp)
.L8: ;middle loop
    cmpl    $99, -8(%rbp)               ; if (j <= 99)
    jle     .L11                        ;    repeat middle loop

    ; i++
    addl    $1, -12(%rbp)
.L7: ;outer loop
    cmpl    $99, -12(%rbp)              ; if (i <= 99)
    jle     .L12                        ;    repeat outer loop

    nop
    nop
    popq    %rbp
    .cfi_def_cfa 7, 8
    ret
    .cfi_endproc
.LFE7:
	.size	multiply_matrices, .-multiply_matrices
	.section	.rodata
	.align 8