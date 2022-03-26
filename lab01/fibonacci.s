
.data
argument: .word  7
str1:     .string "th number in the Fibonacci sequence is "
#str2:     .string " is "

.text
main:
        lw  a0, argument   
        jal ra, fibo1   

        # Print the result to console
        mv  a1, a0
        lw  a0, argument
        jal ra, printResult

        # Exit program
        li a7, 10
        ecall

fibo1:
        addi sp, sp, -16
        sw   ra, 8(sp)
        sw   a0, 0(sp)
        addi t0, a0, -1
        bgt  t0, zero, nfibo01
        beq a0, zero, fibo0

        addi a0, zero, 1
        addi sp, sp, 16
        jr x1
        
fibo0:
        ret

nfibo01:
        addi a0, a0, -1
        jal  ra, fibo1
        addi t1, t2, 0
        addi t2, a0, 0
        lw   a0, 0(sp)
        lw   ra, 8(sp)
        addi sp, sp, 16
        add a0, t1, t2
        ret

# --- printResult ---
printResult:
     
        #mv t0, a0
        mv t1, a1
        li a7,1
        ecall
        la a0, str1
        li a7, 4
        ecall
        mv a0, t1
        li a7, 1
        ecall
        ret
