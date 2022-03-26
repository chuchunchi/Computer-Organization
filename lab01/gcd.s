
.data
N1: .word  4
N2: .word  8
str1:     .string "GCD value of "
str2:     .string " and "
str3:     .string " is "

.text
main:
        lw  a0, N1 
        lw  a1, N2  
        jal ra, gcd

        # Print the result to console
        mv  a2, a0
        lw  a0, N1
        lw  a1, N2
        jal ra,printResult

        # Exit program
        li a7, 10
        ecall

gcd:
        addi sp, sp, -8
        sw   ra, 0(sp)
        bne a1, zero, ngcd

        addi sp, sp, 8
        jr x1

ngcd:
        addi t1, a0, 0
        rem t0, a0, a1
        addi a0, a1, 0
        addi a1, t0, 0
        jal  ra, gcd
        lw   ra, 0(sp)
        addi sp, sp, 8
        ret

# --- printResult ---
printResult:
     
        mv t0, a0
        mv t1, a1
        mv t2, a2
        la a0, str1
        li a7, 4
        ecall
        mv a0, t0
        li a7, 1
        ecall
        la a0, str2
        li a7, 4
        ecall
        mv a0, t1
        li a7, 1
        ecall
        la a0, str3
        li a7, 4
        ecall
        mv a0, t2
        li a7, 1
        ecall
        ret
