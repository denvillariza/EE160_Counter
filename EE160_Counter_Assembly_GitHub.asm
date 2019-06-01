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

;;Initialize Locaiton of varibles
M_ten1	equ 0x00
M_ten2	equ 0x01
M_ten3	equ 0x02
M_ten4	equ 0x03	
M_ten5	equ 0x04
M_ten6	equ 0x05
M_ten7	equ 0x06
M_ten8	equ 0x07
M_ten9	equ 0x08	
MOR	equ 0x09
Cost	equ 0x0A
MAX	equ 0x0B
t_del	equ 0x0C
T_Money equ 0x0D
P5	equ 0x0E
P10	equ 0x0F
Product	equ 0x10;indicator which product is taken
;;				  
Money	equ 0x1C
B_Stock	equ 0x1D
B_Cost	equ 0x1E
A_Stock	equ 0x1F	
A_Cost  equ 0x20
ten1	equ 0x21
ten2	equ 0x22
ten3	equ 0x23
ten4	equ 0x24
ten5	equ 0x25
ten6	equ 0x26
ten7	equ 0x27
ten8	equ 0x28
ten9	equ 0x29
Sub_S	equ 0x2A
DisAB	equ 0x2B
;Setting for Program counter for both start and interrupt
    org 0x0000
    GOTO  Start
    org 0x0008
    GOTO ISR
    org 0x0018
    GOTO ISR
Start
    ;;; Test Money
    
    ;;Initialize Variables
    MOVLW D'5'
    MOVWF P5
    MOVLW D'10'
    MOVWF P10
    MOVLW D'99'
    MOVWF MAX
    MOVLW D'70'
    MOVWF A_Cost;; Heineken (70 Pesos)
    MOVLW D'45'
    MOVWF B_Cost;; Tiger (45 Pesos)
    MOVLW D'2'
    MOVWF A_Stock; Each Has 50 Items
    MOVLW D'95'
    MOVWF B_Stock;
    ;MOVLW 0x0f
    ;IORWF A_Cost, 1, 0
    MOVLW B'00010000'
    MOVWF M_ten1
    MOVLW B'00100000'
    MOVWF M_ten2
    MOVLW B'00110000'
    MOVWF M_ten3
    MOVLW B'01000000'
    MOVWF M_ten4
    MOVLW B'01010000'
    MOVWF M_ten5
    MOVLW B'01100000'
    MOVWF M_ten6
    MOVLW B'01110000'
    MOVWF M_ten7
    MOVLW B'10000000'
    MOVWF M_ten8
    MOVLW B'10010000'
    MOVWF M_ten9
    ;;
    MOVLW D'10'
    MOVWF ten1
    MOVLW D'20'
    MOVWF ten2
    MOVLW D'30'
    MOVWF ten3
    MOVLW D'40'
    MOVWF ten4
    MOVLW D'50'
    MOVWF ten5
    MOVLW D'60'
    MOVWF ten6
    MOVLW D'70'
    MOVWF ten7
    MOVLW D'80'
    MOVWF ten8
    MOVLW D'90'
    MOVWF ten9
    ;;; Initialize Most Significant Byte
    
      ;Initialize Values
    MOVLW 0x60
    MOVWF  OSCCON	;SETTING the FREQUENCY See page 32 of PIC18f4550 SPEC Sheet
     
    BCF UCON,3;; Enable RC4, RC5 as digital inputs 
    BSF UCFG,3
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
    ;;;;;;;;
    CLRF LATA
    CLRF LATB
    CLRF LATC
    CLRF LATD
    CLRF LATE
    ;;;;;;;
    
    MOVLW b'01111100'
    MOVWF TRISA   ;set all PORTA as OUTPUT
    CLRF TRISB	;Setting all PORTB as OUTPUT
   ; CLRF TRISB   ;set all PORTB as OUTPUT
    MOVLW b'00110000'
    MOVWF    TRISC  ; RC4, RC5 are set as digital input by disaling UCON<3> = 0 and UCFG<3> = 1
    ;SETF TRISC   ;set all PORTA as OUTPUT
    CLRF TRISD   ;set all PORTB as OUTPUT
    CLRF TRISE   ;set all PORTA as OUTPUT
    ;;;;;;;;;;;
    
InitVar
    CLRF Money
    CLRF T_Money
    CLRF DisAB
    CLRF Sub_S
    CLRF MOR
    CLRF Product
    Call A_Digit
    Call B_Digit
    Call M_Digit
Check_Product
    BTFSC PORTA,2
    GOTO A_Choose; Choose A product
    BTFSC PORTA,4
    GOTO B_Choose; Choose B product
A_Fall
    BTFSC PORTA,3
    Call A_Restock
B_Fall
    BTFSC PORTA,5
    GOTO B_Restock
    GOTO Check_Product
;;;;;;;;;;
Set_Loop
      MOVLW 0xff
      MOVWF t_del
add_delay;debounce Logic
      DECFSZ t_del
      GOTO add_delay
      Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;debounce logic for A Restock button
A_Restock
    MOVLW D'99'
    CPFSLT A_Stock
    Return
    INCF A_Stock
    Call A_Digit
    Call Set_Loop
wait_A
      BTFSC PORTA,3
      GOTO wait_A
      Return
 ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;debounce logic for B Restock button
B_Restock
    MOVLW D'99'
    CPFSLT B_Stock
    GOTO Check_Product
    INCF B_Stock
    Call B_Digit
    Call Set_Loop
wait_B
      BTFSC PORTA,5
      GOTO wait_B
      GOTO Check_Product
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Part fter product is Chosen
A_Choose
    MOVLW 0x00; Check if there is still stock
    CPFSGT A_Stock
    GOTO Check_Product
    BSF LATA,0;Proceed for next Step
    MOVFF A_Cost, Cost
    ;DECF A_Stock
    ;Call A_Digit; Decrease only once dispense
    GOTO Money_Input
B_Choose
    MOVLW 0x00; Check if there is still stock
    CPFSGT B_Stock
    GOTO Check_Product
    BSF LATA,1; Proceed for next Step
    MOVLW 0xff
    MOVWF Product
    MOVFF B_Cost, Cost
    ;DECF B_Stock
    ;Call B_Digit
    GOTO Money_Input
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Money_Input
    BTFSC PORTA,6
    CALL ADD5
    BTFSC PORTC,4
    CALL ADD10
    BTFSC PORTC,5
    GOTO Dispense
    GOTO Money_Input; Check Input buttons
Dispense
    MOVFF Cost, WREG
    CPFSLT Money
    GOTO Dec_Dis
    GOTO Money_Input
Dec_Dis
    MOVLW 0xff
    CPFSEQ Product
    GOTO DECA
    GOTO DECB
DECA
    DECF A_Stock
    BCF LATA, 0
    GOTO InitVar
DECB
    DECF B_Stock
    BCF LATA, 1
    GOTO InitVar
    
    ;GOTO InitVars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ADD5
    MOVLW D'5'
    ADDWF T_Money, 1, 0
    MOVLW D'100'
    CPFSLT T_Money
    GOTO Max_Money5
    MOVFF T_Money, Money
    Call M_Digit
    Call Set_Loop
wait_5
    BTFSC PORTA,6
    GOTO wait_5
    Return
Max_Money5
    MOVLW D'99'
    MOVWF T_Money
    MOVWF Money
    CALL Set_Loop
    GOTO wait_5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ADD10
    MOVLW D'10'
    ADDWF T_Money, 1, 0
    MOVLW D'100'
    CPFSLT T_Money
    GOTO Max_Money10
    MOVFF T_Money, Money
    Call M_Digit
    Call Set_Loop
wait_10
    BTFSC PORTC,4
    GOTO wait_10
    Return
Max_Money10
    MOVLW D'99'
    MOVWF T_Money
    MOVWF Money
    Call M_Digit
    Call Set_Loop
    GOTO wait_10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
A_Digit
    MOVLW 0x00
    MOVWF Sub_S
    CLRF  DisAB
    MOVFF A_Stock, WREG
    CPFSGT ten1
    MOVFF ten1, Sub_S
    CPFSGT ten2
    MOVFF ten2, Sub_S
    CPFSGT ten3
    MOVFF ten3, Sub_S
    CPFSGT ten4
    MOVFF ten4, Sub_S
    CPFSGT ten5
    MOVFF ten5, Sub_S
    CPFSGT ten6
    MOVFF ten6, Sub_S
    CPFSGT ten7
    MOVFF ten7, Sub_S
    CPFSGT ten8
    MOVFF ten8, Sub_S
    CPFSGT ten9
    MOVFF ten9, Sub_S
    ;MOVLW 0x0A
    ;MOVWF Sub_S
    ;MOVLW 0x10
    BSF STATUS, 0;; set Carry to 1. 
    SUBFWB Sub_S , 0, 0 ;Cost - tens = first digit
    MOVWF DisAB
    ;MOVFF  DisAB, LATB
    ;; For most significant 4bits
    MOVFF Sub_S, WREG
    CPFSGT ten1
    MOVFF M_ten1, MOR
    CPFSGT ten2
    MOVFF M_ten2, MOR
    CPFSGT ten3
    MOVFF M_ten3, MOR
    CPFSGT ten4
    MOVFF M_ten4, MOR
    CPFSGT ten5
    MOVFF M_ten5, MOR
    CPFSGT ten6
    MOVFF M_ten6, MOR
    CPFSGT ten7
    MOVFF M_ten7, MOR
    CPFSGT ten8
    MOVFF M_ten8, MOR
    CPFSGT ten9
    MOVFF M_ten9, MOR
    MOVFF MOR,WREG
    IORWF DisAB, 1, 0
    ;MOVFF Sub_S, WREG
    MOVFF DisAB, LATB
    RETURN
    ;MOVLW 0x0f
    ;IORWF A_Cost, 1, 0
B_Digit
    MOVLW 0x00
    MOVWF Sub_S
    CLRF MOR
    MOVFF B_Stock, WREG
    CPFSGT ten1
    MOVFF ten1, Sub_S
    CPFSGT ten2
    MOVFF ten2, Sub_S
    CPFSGT ten3
    MOVFF ten3, Sub_S
    CPFSGT ten4
    MOVFF ten4, Sub_S
    CPFSGT ten5
    MOVFF ten5, Sub_S
    CPFSGT ten6
    MOVFF ten6, Sub_S
    CPFSGT ten7
    MOVFF ten7, Sub_S
    CPFSGT ten8
    MOVFF ten8, Sub_S
    CPFSGT ten9
    MOVFF ten9, Sub_S
    BSF STATUS, 0;; set Carry to 1. 
    SUBFWB Sub_S , 0, 0 ;Cost - tens = first digit
    MOVWF DisAB
    ;MOVFF  DisAB, LATD
    MOVFF Sub_S, WREG
    CPFSGT ten1
    MOVFF M_ten1, MOR
    CPFSGT ten2
    MOVFF M_ten2, MOR
    CPFSGT ten3
    MOVFF M_ten3, MOR
    CPFSGT ten4
    MOVFF M_ten4, MOR
    CPFSGT ten5
    MOVFF M_ten5, MOR
    CPFSGT ten6
    MOVFF M_ten6, MOR
    CPFSGT ten7
    MOVFF M_ten7, MOR
    CPFSGT ten8
    MOVFF M_ten8, MOR
    CPFSGT ten9
    MOVFF M_ten9, MOR
    MOVFF MOR,WREG
    IORWF DisAB, 1, 0
    MOVFF DisAB, LATD
    RETURN
M_Digit
    MOVLW 0x00
    MOVWF Sub_S
    CLRF MOR
    MOVFF Money, WREG
    CPFSGT ten1
    MOVFF ten1, Sub_S
    CPFSGT ten2
    MOVFF ten2, Sub_S
    CPFSGT ten3
    MOVFF ten3, Sub_S
    CPFSGT ten4
    MOVFF ten4, Sub_S
    CPFSGT ten5
    MOVFF ten5, Sub_S
    CPFSGT ten6
    MOVFF ten6, Sub_S
    CPFSGT ten7
    MOVFF ten7, Sub_S
    CPFSGT ten8
    MOVFF ten8, Sub_S
    CPFSGT ten9
    MOVFF ten9, Sub_S
    BSF STATUS, 0;; set Carry to 1. 
    SUBFWB Sub_S , 0, 0 ;Cost - tens = first digit
    MOVWF DisAB
    BTFSC DisAB,3
    BSF DisAB, 6
    ;;;
    MOVFF Sub_S, WREG
    CPFSGT ten1
    MOVFF M_ten1, MOR
    CPFSGT ten2
    MOVFF M_ten2, MOR
    CPFSGT ten3
    MOVFF M_ten3, MOR
    CPFSGT ten4
    MOVFF M_ten4, MOR
    CPFSGT ten5
    MOVFF M_ten5, MOR
    CPFSGT ten6
    MOVFF M_ten6, MOR
    CPFSGT ten7
    MOVFF M_ten7, MOR
    CPFSGT ten8
    MOVFF M_ten8, MOR
    CPFSGT ten9
    MOVFF M_ten9, MOR
    BTFSC MOR,4
    BSF DisAB, 7
    MOVFF DisAB, LATC
    CLRF LATE
    BTFSC MOR,5
    BSF LATE, 0
    BTFSC MOR,6
    BSF LATE, 1
    BTFSC MOR,7
    BSF LATE,2
    Return
    
ISR
    MOVLW b'01000001'
    MOVWF LATA
    GOTO ISR 
    
END
