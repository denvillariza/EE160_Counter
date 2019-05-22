    ;-------------------------------------------;
    ;Project of EE160				;
    ;Counter					;
    ;-------------------------------------------;
    
    
    LIST P=18F4550      ;directive to define processor
    #include <P18F4550.INC>   ;processor specific variable definitions
    CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
    CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
    CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) 
				  ;(USB clock source comes directly from the primary oscillator block with no postscale)

    ; CONFIG1H
      CONFIG  FOSC = INTOSCIO_EC    ; Oscillator Selection bits (Internal oscillator, port function on RA6, EC used by USB (INTIO))
      CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
      CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

    ; CONFIG2L
      CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
      CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
      CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
      CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

    ; CONFIG2H
      CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
      CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

    ; CONFIG3H
      CONFIG  CCP2MX = OFF          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RB3)
      CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
      CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
      CONFIG  MCLRE = OFF            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

    ; CONFIG4L ;STVREN;OKEASEEEEE
      CONFIG  STVREN = OFF           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
      CONFIG  LVP = OFF              ; Single-Supply ICSP Enable bit (Single-Supply ICSP enabled)
      CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
      CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode 
				    ; disabled (Legacy mode))

    ; CONFIG5L
      CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
      CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
      CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
      CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

    ; CONFIG5H
      CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
      CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

    ; CONFIG6L
      CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
      CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
      CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
      CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
    CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
    CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
    CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

  ; CONFIG7L
    CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
    CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
    CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
    CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

  ; CONFIG7H
    CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in 
				  ; other blocks)


; Setting of variables in register addresses
count1 equ 0x20
count2 equ 0x21
count3 equ 0x22
checker_s equ 0x23
upcount equ 0x30
upmax equ 0x31
zeroth equ 0x32
add_del equ 0x33
;;;;;;number for simplicity
d0	equ 0x34
d1	equ 0x35
d2	equ 0x36
d3	equ 0x37
d4	equ 0x38
d5	equ 0x39
d6	equ 0x3A
d7	equ 0x3B
d8	equ 0x3C
d9	equ 0x3D
;;;;; First segment
f0	equ 0x3E
f1	equ 0x3F
f2	equ 0x40
f3	equ 0x41
f4	equ 0x42
f5	equ 0x43
f6	equ 0x44
f7	equ 0x45
f8	equ 0x46
f9	equ 0x47
;;;;;  second segmend
s0	equ 0x48
s1	equ 0x49
s2	equ 0x4A
s3	equ 0x4B
s4	equ 0x4C
s5	equ 0x4D
s6	equ 0x4E
s7	equ 0x4F
s8	equ 0x50
s9	equ 0x51
;;;;;;;third segment
t0	equ 0x52
t1	equ 0x53
t2	equ 0x54
t3	equ 0x55
t4	equ 0x56
t5	equ 0x57
t6	equ 0x58
t7	equ 0x59
t8	equ 0x5A
t9	equ 0x5B
one	equ 0x5C
ten	equ 0x5D
minute	equ 0x5E
;b2	equ 0X5F
;b1	equ 0x60
;b0	equ 0x61
b2	equ 0X1F// TWO of the pin in LATC has no Digital Output Capabilities
b1	equ 0x1E// thus will use two segments from LATB insteadsss
b0	equ 0x1D
	
;Setting for Program counter for both start and interrupt
    org 0x0000
    GOTO  Start
    org 0x0008
    GOTO ISR// Interrupt failed to work. Possible because of lack of Pull-up or pull-dow resistors
    org 0x0018
    GOTO ISR
//START of PROGRAM
Start
      ;Initialize Values
      MOVLW 0x60
      MOVWF  OSCCON	;SETTING the FREQUENCY See page 32 of PIC18f4550 SPEC Sheet
      MOVLW 0x09
      MOVWF	upmax
   ;;;;;; intiialize values
      MOVLW 0x00
      MOVWF d0
      MOVLW 0x01
      MOVWF d1
      MOVLW 0x02
      MOVWF d2
      MOVLW 0x03
      MOVWF d3
      MOVLW 0x04
      MOVWF d4
      MOVLW 0x05
      MOVWF d5
      MOVLW 0x06
      MOVWF d6
      MOVLW 0x07
      MOVWF d7
      MOVLW 0x08
      MOVWF d8
      MOVLW 0x09
      MOVWF d9
      nop
      ;;;; 7segment initialize;; first digit same with third digit output
      MOVLW b'00111111'
      MOVWF f0
      MOVLW  b'00000110'
      MOVWF f1
      MOVLW b'01011011'
      MOVWF f2
      MOVLW b'01001111'
      MOVWF f3
      MOVLW b'01100110'
      MOVWF f4
      MOVLW b'01101101'
      MOVWF f5
      MOVLW b'01111101'
      MOVWF f6
      MOVLW b'00000111'
      MOVWF f7
      MOVLW b'011111111'
      MOVWF f8
      MOVLW b'01100111'
      MOVWF f9
      nop
      ;;;;;;;
      MOVLW b'01110111'
      MOVWF s0
      MOVLW b'00000110'
      MOVWF s1
      MOVLW b'10110011'
      MOVWF s2
      MOVLW b'10010111'
      MOVWF s3
      MOVLW b'11000110'
      MOVWF s4
      MOVLW b'11010101'
      MOVWF s5
      MOVLW b'11110101'
      MOVWF s6
      MOVLW b'00000111'
      MOVWF s7
      MOVLW b'11110111'
      MOVWF s8
      MOVLW b'11000111'
      MOVWF s9
      ;;;;;;;
      MOVLW b'00111111'
      MOVWF t0
      MOVLW  b'00000110'
      MOVWF t1
      MOVLW b'01011011'
      MOVWF t2
      MOVLW b'01001111'
      MOVWF t3
      MOVLW b'01100110'
      MOVWF t4
      MOVLW b'01101101'
      MOVWF t5
      MOVLW b'01111101'
      MOVWF t6
      MOVLW b'00000111'
      MOVWF t7	 
      MOVLW b'011111111'
      MOVWF t8
      MOVLW b'01100111'
      MOVWF t9
      nop
      MOVLW 0x01
      MOVWF b1
      MOVLW 0x03
      MOVWF b2
      MOVLW 0x00
      MOVWF b0
      nop
      
      
      
    MOVLW   0x00    
    MOVWF   ADCON0  ;AD Converver OFF
      
      
    MOVLW   0x0f
    MOVWF    ADCON1    
     ;;;;;;;;;;;
    CLRF PORTA	;Just clearing for safety Pruposes
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    CLRF TRISA   ;set all PORTA as OUTPUT
    MOVLW b'0001100'
    MOVWF TRISB	;Setting some ports to IssNPUT
   ; CLRF TRISB   ;set all PORTB as OUTPUT
    CLRF TRISC   ;set all PORTA as OUTPUT
    CLRF TRISD   ;set all PORTB as OUTPUT
    CLRF TRISE   ;set all PORTA as OUTPUT
    
    
    

    
   ; BSF TRISB, 0   ;set RB0 as input
  ;  BSF TRISB, 1
  ;MOVLW b'01000000'
   ; MOVWF   INTCON2

    MOVLW 0x00
    nop
    CALL second_digit	;Function cll to display numbers
    nop
    CALL first_digit
    CALL first_digit
    nop
    CALL third_digit
    nop
    CALL first_digit
    MOVWF one
    MOVWF ten
    MOVWF checker_s
    GOTO Init
ISR
    MOVLW b'01000001'
    MOVWF LATA
    GOTO ISR
Init
    ;CLRF LATA
    CLRF zeroth
    CLRF upcount
    MOVLW 0x09
    MOVWF upmax
    
check_up    ;Check if Up button is pressed
    BTFSS PORTB,2
    GOTO check_start
    GOTO add_check
 
check_start ;check if Start Button is pressed
     BTFSS PORTB,3
     GOTO check_up
     GOTO  cstart
     
add_check;;;;;;
     MOVFF upcount,WREG
     CPFSEQ upmax ;check if equal to 9
     GOTO add
     GOTO check_start
add
      INCF	upcount
      MOVFF upcount,WREG
      ;MOVFF WREG,LATA
     CALL first_digit;;;;; convert to seven segment
     nop
fback 
      MOVLW 0xff
      MOVWF add_del
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
add_delay;debounce Logic
      DECFSZ add_del
      GOTO add_delay
wait_fall
      BTFSC PORTB,2
      GOTO wait_fall
      GOTO check_start
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cstart
      MOVFF upcount,WREG
      CPFSLT zeroth;;if upount>zeroth skip
      GOTO check_up
      GOTO  loop1;initial
   
ten_set
    MOVLW 0x05
    MOVWF ten
one_set
    movlw 0x09
    MOVWF one   
loop1
;;;; Algorithm for loop1
    ;1. Display First All Values
    ;2. Decrement 'one'
    ;3. Check if the counter is now only at 10 seconds
    ;4. Delay for 1 second
    ;5. Check if boolean from # 3 is true of false
    ;5a.    If yes, proceed to mili Algorithmm
    ;5b.    Otherwise, continue loop1 algorithm
    ;6.	Check if 'on'e value is 255.(if a value of zero is decremented, the resulting value will be 255.)
    ;6a.    If yes, and tens value will be deducted
    ;6b.    Otherwise, restart loop1 Algorithm, If the previous condition is true
    ;7	 Check if 'tens' reached 255
    ;7a	    If yes, 'tens' and 'ones' value will be reinitaized and value of 'upcount'(minute) will be deducted
    ;7b	    If no, continue, the ones value will only be reinitailized
    MOVFF upcount,WREG	;1
    nop
    call first_digit
    call first_digit
    call first_digit
    MOVFF ten,WREG
    call second_digit
    MOVFF one,WREG
    call third_digit
 ;;;;;;;;;;
    decf one	    ;2
    CALL check_shift	;3
    ;;;;Delay
    Call s1_set	;4
    ;;;;;;;
    
    movlw 0x00
    CPFSEQ checker_s	;5
    GOTO mili	;5a
    ;;;;;;;;
    movlw 0xff	;5b
    CPFSEQ one	;6b
    GOTO loop1	;
    
    decf ten	;6a
   ;;;initial
    
    ;;; insert if statement
    movlw 0xff
    CPFSEQ ten	;7
    GOTO one_set    ;7b
    decf upcount    ;7a
    
    GOTO ten_set
check_shift; Checking if one = 0, minute = 0, and tens = 0
      movlw 0x00
      CPFSEQ upcount
      Return
       movlw 0x00
      CPFSEQ one
      Return
      MOVLW 0x01
      CPFSEQ ten
      Return
      SETF checker_s
      Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Delay for 1 s// recommend using online delay generator
s1_set; 
     movlw	0xce
     movwf	count1
      movlw	0x91
      movwf	count2
      movlw	0x05
      movwf	count3
Delay1
     decfsz	count1, f
    goto	Delay1
    decfsz	count2, f
    goto	Delay1
    decfsz	count3, f
    goto	Delay1
    nop
    Return
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Delay for 10 ms
s2_set
     movlw	0xad
     movwf	count1
      movlw	0x0c
      movwf	count2

Delay2
     decfsz	count1, f
	goto	Delay2
	decfsz	count2, f
	goto	Delay2
    Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mili
      MOVLW 0x09
    MOVWF upcount; for debuggin purposes
ten_setm
    MOVLW 0x09
    MOVWF ten
one_setm
    movlw 0x09
    MOVWF one   
loop2
;;;; Algorithm for loop2
    ;1. Display First All Values
    ;2. Decrement 'one'
    ;3. Check if 'one' is 255
    ;3a.    If yes, 'tens' will be deducted
    ;3b.    Otherwise, call loop2 algorithm again
    ;4.	Check if 'ten' value is 255.
    ;4a.    If yes, 'upstart'(now the second) value will be deducted'
    ;4b.    Otherwise, the value of 'one' will be reinitialized
    ;5	 Check if upstart reached 255
    ;5a	    If yes, the code will reset itself
    ;5b	    If no, both value of 'tens' and ones' will be reinitialized
    MOVFF upcount,WREG	;1
    nop
    call first_digit
    call first_digit
    call first_digit
    MOVFF ten,WREG
    call second_digit
    MOVFF one,WREG
    call third_digit
    ;;;;;;;;;;;;;;
    decf one		;2
    
    ;;;;Delay
    Call s2_set		;3
    ;;
    movlw 0xff
    CPFSEQ one
    GOTO loop2		;3b
    decf ten		;3a
    CPFSEQ ten		;4
    GOTO one_setm	;4b
    decf upcount	;4a
    CPFSEQ upcount	;5
    GOTO ten_setm	;5b
     Reset		;5a
      
      
      ;;;;;;;;;;;;;;;;;
first_digit
     CPFSLT d9
      MOVFF t9, LATD
     CPFSLT  d8
      MOVFF t8, LATD
     CPFSLT  d7
      MOVFF t7, LATD
     CPFSLT  d6
      MOVFF t6, LATD
     CPFSLT  d5
      MOVFF t5, LATD
     CPFSLT  d4
      MOVFF t4, LATD
     CPFSLT  d3
      MOVFF t3, LATD
     CPFSLT  d2
      MOVFF t2, LATD
     CPFSLT  d1
      MOVFF t1, LATD
     CPFSLT  d0
      MOVFF t0, LATD
     RETURN
second_digit
     CPFSLT d9
      MOVFF s9, LATC
     CPFSLT  d8
      MOVFF s8, LATC
     CPFSLT  d7
      MOVFF s7, LATC
     CPFSLT  d6
      MOVFF s6, LATC
     CPFSLT  d5
      MOVFF s5, LATC
     CPFSLT  d4
      MOVFF s4, LATC
     CPFSLT  d3
      MOVFF s3, LATC
     CPFSLT  d2
      MOVFF s2, LATC
     CPFSLT  d1
      MOVFF s1, LATC
     CPFSLT  d0
      MOVFF s0, LATC
      
     CPFSLT  d9
      MOVFF b0, LATB
     CPFSLT  d8
      MOVFF b2, LATB
     CPFSLT  d7
      MOVFF b0, LATB
     CPFSLT  d6
      MOVFF b2, LATB
     CPFSLT  d5
      MOVFF b1, LATB
     CPFSLT  d4
      MOVFF b0,LATB
     CPFSLT  d3
      MOVFF b1, LATB
     CPFSLT  d2
      MOVFF b2, LATB
     CPFSLT  d1
      MOVFF b0, LATB
     CPFSLT  d0
      MOVFF b2, LATB
     RETURN
third_digit
     CPFSLT d9
      MOVFF f9, LATA
     CPFSLT  d8
      MOVFF f8, LATA
     CPFSLT  d7
      MOVFF f7, LATA
     CPFSLT  d6
      MOVFF f6, LATA
     CPFSLT  d5
      MOVFF f5, LATA
     CPFSLT  d4
      MOVFF f4, LATA
     CPFSLT  d3
      MOVFF f3, LATA
     CPFSLT  d2
      MOVFF f2, LATA
     CPFSLT  d1
      MOVFF f1, LATA
      CPFSLT  d0
      MOVFF f0, LATA
     RETURN
    END