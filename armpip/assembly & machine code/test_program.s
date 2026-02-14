        AREA    TEST, CODE, READONLY
        ENTRY

        MOV     R0, #0
        MOV     R1, #10
        MOV     R2, #3

        ADD     R3, R1, R2

        SUB     R4, R3, R1

        MOV     R5, #0xFF
        MOV     R6, #0x0F
        AND     R7, R5, R6

        MOV     R8, #0xA0
        ORR     R9, R8, R6

        MOV     R0, #0xFF
        MOV     R1, #0x0F
        BIC     R2, R0, R1

        MOV     R3, #0xAA
        MOV     R4, #0x55
        EOR     R5, R3, R4

        MOV     R0, #0
        MOV     R1, #42
        STR     R1, [R0, #0]
        STR     R5, [R0, #4]

        LDR     R6, [R0, #0]
        LDR     R7, [R0, #4]

        MOV     R0, #0
        STR     R1, [R0, #8]
        LDR     R8, [R0, #8]
        ADD     R9, R8, #1

        MOV     R0, #0
        MOV     R10, #100
        B       skip
        MOV     R10, #99
        MOV     R10, #98
skip
        MOV     R10, #7

        MOV     R0, #5
        MOV     R1, #10
        ADD     R2, R0, R1
        ADD     R3, R2, R0
        SUB     R4, R3, R2

        MOV     R0, #100
        STR     R10, [R0, #0]

done
        B       done

        END
