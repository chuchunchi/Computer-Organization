
.data
arr: .word   5,3,6,7,31,23,43,12,45,1
size: .word 10
str1:        .string "Array¡G\n"

str2:        .string "\nSorted¡G\n"
str3:        .string " "

.text
main:
        la a2, arr
        lw a1, size

        jal ra, print      # Jump-and-link to the 'fact' label
        jal ra, bubblesort
        jal ra, printarr

        # Exit program
        li a7, 10
        ecall
     

bubblesort:
        #a3=j ,a4=i
        addi a4, zero, -1
        loopi:
            addi a4, a4, 1
            beq a4, a1, exit
            addi a3,a4,0
            loopj:
                addi a3,a3,-1
                blt a3, x0, loopi
                slli t1, a3, 2
                slli s0, a4, 2
                add  t1, a2, t1
                lw   t0, 0(t1)
                lw   t2, 4(t1)
                ble  t0, t2, loopj
                sw   t2, 0(t1)
                sw   t0, 4(t1)
                beq  x0, x0, loopj

        exit:
        ret
     
print:
        la a0, str1
        li a7, 4
        ecall
        addi sp,sp,-8
        sw ra, 0(sp)
        jal ra, printarr
        
        la a0, str2
        li a7, 4
        ecall
        lw ra, 0(sp)
        addi sp,sp,8
        ret
printarr:
        mv t0,a2
        slli t2, a1, 2
        add t1, t0, t2
        loop:
        
        lw a0, 0(t0)
        li a7, 1
        ecall
        la a0, str3
        li a7, 4
        ecall
        addi t0, t0, 4
        bne t0, t1, loop
        jr x1
