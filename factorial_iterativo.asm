.data
prompt: .asciiz "Ingrese el numero a calcular:  " # print string
space:  .asciiz "\n"        # space between numbers

.text
.globl main
main:

## Ingreso y leo el numero
li		      $v0, 4		        # syscall read string code
la		      $a0, prompt		    # load prompt adress
syscall                       # read prompt (number)
li          $v0, 5            # syscall read_int code
syscall                       # read number
move        $t0, $v0          # move number in $v0 to $t0
li		      $v0, 4		        # syscall read string code
la		      $a0, space		    # read space
syscall                       # add space

## CASO DE 1 Y 0
beq         $t0, 1, bye  # if number == 1 goto bye
beq         $t0, 0, bye  # if number == 1 goto bye

## Se le resta 1 al numero elegido
addi		    $t1, $t0, -1      # $t1 = $t0-- (number - 1)

## Se salta a la funcion que calcula el factorial
jal         loop              # jump to "loop" target and save position to $ra

## Finaliza el programa
li		      $v0, 10		        # syscall halt code
syscall                       # halt

## Operacion en loop que calcula el factorial
loop:
beq		      $t1, $zero, exit  # if $t1 == 0 go to exit
mul         $t0, $t0, $t1     # number *=  number-1
addi		    $t1, $t1, -1      # $t1 = $t0-- (number - 1)
j           loop              # jump to loop

## Se imprime el resultado 
exit:
li          $v0, 1            # syscall print int code
move        $a0, $t0          # move $t0 to $a0
syscall

## Vuelvo a la instruccion seguida al jal (Finaliza el programa)
jr    $ra

## Caso 1 y 0 => Imprimo numero y termino el programa
bye:
li          $v0, 1            # syscall print int code
move        $a0, $t0          # move $t0 to $a0
syscall
li		      $v0, 10		        # syscall halt code
syscall
