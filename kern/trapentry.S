/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>

#include <kern/picirq.h>


###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name##num:			/* function starts here */		\
	pushl $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name##num:								\
	pushl $0;							\
	pushl $(num);							\
	jmp _alltraps

.text

/*
 * Lab 3: Your code here for generating entry points for the different traps.
 */
 .globl _alltraps

TRAPHANDLER_NOEC(vector, 0)
TRAPHANDLER_NOEC(vector, 1)
TRAPHANDLER_NOEC(vector, 2)
TRAPHANDLER_NOEC(vector, 3)
TRAPHANDLER_NOEC(vector, 4)
TRAPHANDLER_NOEC(vector, 5)
TRAPHANDLER_NOEC(vector, 6)
TRAPHANDLER_NOEC(vector, 7)
TRAPHANDLER(vector, 8)
TRAPHANDLER_NOEC(vector, 9)
TRAPHANDLER(vector, 10)
TRAPHANDLER(vector, 11)
TRAPHANDLER(vector, 12)
TRAPHANDLER(vector, 13)
TRAPHANDLER(vector, 14)
TRAPHANDLER_NOEC(vector, 15)
TRAPHANDLER_NOEC(vector, 16)
TRAPHANDLER(vector, 17)
TRAPHANDLER_NOEC(vector, 18)
TRAPHANDLER_NOEC(vector, 19)
TRAPHANDLER_NOEC(vector, 20)
TRAPHANDLER_NOEC(vector, 21)
TRAPHANDLER_NOEC(vector, 22)
TRAPHANDLER_NOEC(vector, 23)
TRAPHANDLER_NOEC(vector, 24)
TRAPHANDLER_NOEC(vector, 25)
TRAPHANDLER_NOEC(vector, 26)
TRAPHANDLER_NOEC(vector, 27)
TRAPHANDLER_NOEC(vector, 28)
TRAPHANDLER_NOEC(vector, 29)
TRAPHANDLER_NOEC(vector, 30)
TRAPHANDLER_NOEC(vector, 31)
TRAPHANDLER_NOEC(vector, 32)
TRAPHANDLER_NOEC(vector, 33)
TRAPHANDLER_NOEC(vector, 34)
TRAPHANDLER_NOEC(vector, 35)
TRAPHANDLER_NOEC(vector, 36)
TRAPHANDLER_NOEC(vector, 37)
TRAPHANDLER_NOEC(vector, 38)
TRAPHANDLER_NOEC(vector, 39)
TRAPHANDLER_NOEC(vector, 40)
TRAPHANDLER_NOEC(vector, 41)
TRAPHANDLER_NOEC(vector, 42)
TRAPHANDLER_NOEC(vector, 43)
TRAPHANDLER_NOEC(vector, 44)
TRAPHANDLER_NOEC(vector, 45)
TRAPHANDLER_NOEC(vector, 46)
TRAPHANDLER_NOEC(vector, 47)
TRAPHANDLER_NOEC(vector, 48)
TRAPHANDLER_NOEC(vector, 49)
TRAPHANDLER_NOEC(vector, 50)
TRAPHANDLER_NOEC(vector, 51)
TRAPHANDLER_NOEC(vector, 52)
TRAPHANDLER_NOEC(vector, 53)
TRAPHANDLER_NOEC(vector, 54)
TRAPHANDLER_NOEC(vector, 55)
TRAPHANDLER_NOEC(vector, 56)
TRAPHANDLER_NOEC(vector, 57)
TRAPHANDLER_NOEC(vector, 58)
TRAPHANDLER_NOEC(vector, 59)
TRAPHANDLER_NOEC(vector, 60)
TRAPHANDLER_NOEC(vector, 61)
TRAPHANDLER_NOEC(vector, 62)
TRAPHANDLER_NOEC(vector, 63)
TRAPHANDLER_NOEC(vector, 64)
TRAPHANDLER_NOEC(vector, 65)
TRAPHANDLER_NOEC(vector, 66)
TRAPHANDLER_NOEC(vector, 67)
TRAPHANDLER_NOEC(vector, 68)
TRAPHANDLER_NOEC(vector, 69)
TRAPHANDLER_NOEC(vector, 70)
TRAPHANDLER_NOEC(vector, 71)
TRAPHANDLER_NOEC(vector, 72)
TRAPHANDLER_NOEC(vector, 73)
TRAPHANDLER_NOEC(vector, 74)
TRAPHANDLER_NOEC(vector, 75)
TRAPHANDLER_NOEC(vector, 76)
TRAPHANDLER_NOEC(vector, 77)
TRAPHANDLER_NOEC(vector, 78)
TRAPHANDLER_NOEC(vector, 79)
TRAPHANDLER_NOEC(vector, 80)
TRAPHANDLER_NOEC(vector, 81)
TRAPHANDLER_NOEC(vector, 82)
TRAPHANDLER_NOEC(vector, 83)
TRAPHANDLER_NOEC(vector, 84)
TRAPHANDLER_NOEC(vector, 85)
TRAPHANDLER_NOEC(vector, 86)
TRAPHANDLER_NOEC(vector, 87)
TRAPHANDLER_NOEC(vector, 88)
TRAPHANDLER_NOEC(vector, 89)
TRAPHANDLER_NOEC(vector, 90)
TRAPHANDLER_NOEC(vector, 91)
TRAPHANDLER_NOEC(vector, 92)
TRAPHANDLER_NOEC(vector, 93)
TRAPHANDLER_NOEC(vector, 94)
TRAPHANDLER_NOEC(vector, 95)
TRAPHANDLER_NOEC(vector, 96)
TRAPHANDLER_NOEC(vector, 97)
TRAPHANDLER_NOEC(vector, 98)
TRAPHANDLER_NOEC(vector, 99)
TRAPHANDLER_NOEC(vector, 100)
TRAPHANDLER_NOEC(vector, 101)
TRAPHANDLER_NOEC(vector, 102)
TRAPHANDLER_NOEC(vector, 103)
TRAPHANDLER_NOEC(vector, 104)
TRAPHANDLER_NOEC(vector, 105)
TRAPHANDLER_NOEC(vector, 106)
TRAPHANDLER_NOEC(vector, 107)
TRAPHANDLER_NOEC(vector, 108)
TRAPHANDLER_NOEC(vector, 109)
TRAPHANDLER_NOEC(vector, 110)
TRAPHANDLER_NOEC(vector, 111)
TRAPHANDLER_NOEC(vector, 112)
TRAPHANDLER_NOEC(vector, 113)
TRAPHANDLER_NOEC(vector, 114)
TRAPHANDLER_NOEC(vector, 115)
TRAPHANDLER_NOEC(vector, 116)
TRAPHANDLER_NOEC(vector, 117)
TRAPHANDLER_NOEC(vector, 118)
TRAPHANDLER_NOEC(vector, 119)
TRAPHANDLER_NOEC(vector, 120)
TRAPHANDLER_NOEC(vector, 121)
TRAPHANDLER_NOEC(vector, 122)
TRAPHANDLER_NOEC(vector, 123)
TRAPHANDLER_NOEC(vector, 124)
TRAPHANDLER_NOEC(vector, 125)
TRAPHANDLER_NOEC(vector, 126)
TRAPHANDLER_NOEC(vector, 127)
TRAPHANDLER_NOEC(vector, 128)
TRAPHANDLER_NOEC(vector, 129)
TRAPHANDLER_NOEC(vector, 130)
TRAPHANDLER_NOEC(vector, 131)
TRAPHANDLER_NOEC(vector, 132)
TRAPHANDLER_NOEC(vector, 133)
TRAPHANDLER_NOEC(vector, 134)
TRAPHANDLER_NOEC(vector, 135)
TRAPHANDLER_NOEC(vector, 136)
TRAPHANDLER_NOEC(vector, 137)
TRAPHANDLER_NOEC(vector, 138)
TRAPHANDLER_NOEC(vector, 139)
TRAPHANDLER_NOEC(vector, 140)
TRAPHANDLER_NOEC(vector, 141)
TRAPHANDLER_NOEC(vector, 142)
TRAPHANDLER_NOEC(vector, 143)
TRAPHANDLER_NOEC(vector, 144)
TRAPHANDLER_NOEC(vector, 145)
TRAPHANDLER_NOEC(vector, 146)
TRAPHANDLER_NOEC(vector, 147)
TRAPHANDLER_NOEC(vector, 148)
TRAPHANDLER_NOEC(vector, 149)
TRAPHANDLER_NOEC(vector, 150)
TRAPHANDLER_NOEC(vector, 151)
TRAPHANDLER_NOEC(vector, 152)
TRAPHANDLER_NOEC(vector, 153)
TRAPHANDLER_NOEC(vector, 154)
TRAPHANDLER_NOEC(vector, 155)
TRAPHANDLER_NOEC(vector, 156)
TRAPHANDLER_NOEC(vector, 157)
TRAPHANDLER_NOEC(vector, 158)
TRAPHANDLER_NOEC(vector, 159)
TRAPHANDLER_NOEC(vector, 160)
TRAPHANDLER_NOEC(vector, 161)
TRAPHANDLER_NOEC(vector, 162)
TRAPHANDLER_NOEC(vector, 163)
TRAPHANDLER_NOEC(vector, 164)
TRAPHANDLER_NOEC(vector, 165)
TRAPHANDLER_NOEC(vector, 166)
TRAPHANDLER_NOEC(vector, 167)
TRAPHANDLER_NOEC(vector, 168)
TRAPHANDLER_NOEC(vector, 169)
TRAPHANDLER_NOEC(vector, 170)
TRAPHANDLER_NOEC(vector, 171)
TRAPHANDLER_NOEC(vector, 172)
TRAPHANDLER_NOEC(vector, 173)
TRAPHANDLER_NOEC(vector, 174)
TRAPHANDLER_NOEC(vector, 175)
TRAPHANDLER_NOEC(vector, 176)
TRAPHANDLER_NOEC(vector, 177)
TRAPHANDLER_NOEC(vector, 178)
TRAPHANDLER_NOEC(vector, 179)
TRAPHANDLER_NOEC(vector, 180)
TRAPHANDLER_NOEC(vector, 181)
TRAPHANDLER_NOEC(vector, 182)
TRAPHANDLER_NOEC(vector, 183)
TRAPHANDLER_NOEC(vector, 184)
TRAPHANDLER_NOEC(vector, 185)
TRAPHANDLER_NOEC(vector, 186)
TRAPHANDLER_NOEC(vector, 187)
TRAPHANDLER_NOEC(vector, 188)
TRAPHANDLER_NOEC(vector, 189)
TRAPHANDLER_NOEC(vector, 190)
TRAPHANDLER_NOEC(vector, 191)
TRAPHANDLER_NOEC(vector, 192)
TRAPHANDLER_NOEC(vector, 193)
TRAPHANDLER_NOEC(vector, 194)
TRAPHANDLER_NOEC(vector, 195)
TRAPHANDLER_NOEC(vector, 196)
TRAPHANDLER_NOEC(vector, 197)
TRAPHANDLER_NOEC(vector, 198)
TRAPHANDLER_NOEC(vector, 199)
TRAPHANDLER_NOEC(vector, 200)
TRAPHANDLER_NOEC(vector, 201)
TRAPHANDLER_NOEC(vector, 202)
TRAPHANDLER_NOEC(vector, 203)
TRAPHANDLER_NOEC(vector, 204)
TRAPHANDLER_NOEC(vector, 205)
TRAPHANDLER_NOEC(vector, 206)
TRAPHANDLER_NOEC(vector, 207)
TRAPHANDLER_NOEC(vector, 208)
TRAPHANDLER_NOEC(vector, 209)
TRAPHANDLER_NOEC(vector, 210)
TRAPHANDLER_NOEC(vector, 211)
TRAPHANDLER_NOEC(vector, 212)
TRAPHANDLER_NOEC(vector, 213)
TRAPHANDLER_NOEC(vector, 214)
TRAPHANDLER_NOEC(vector, 215)
TRAPHANDLER_NOEC(vector, 216)
TRAPHANDLER_NOEC(vector, 217)
TRAPHANDLER_NOEC(vector, 218)
TRAPHANDLER_NOEC(vector, 219)
TRAPHANDLER_NOEC(vector, 220)
TRAPHANDLER_NOEC(vector, 221)
TRAPHANDLER_NOEC(vector, 222)
TRAPHANDLER_NOEC(vector, 223)
TRAPHANDLER_NOEC(vector, 224)
TRAPHANDLER_NOEC(vector, 225)
TRAPHANDLER_NOEC(vector, 226)
TRAPHANDLER_NOEC(vector, 227)
TRAPHANDLER_NOEC(vector, 228)
TRAPHANDLER_NOEC(vector, 229)
TRAPHANDLER_NOEC(vector, 230)
TRAPHANDLER_NOEC(vector, 231)
TRAPHANDLER_NOEC(vector, 232)
TRAPHANDLER_NOEC(vector, 233)
TRAPHANDLER_NOEC(vector, 234)
TRAPHANDLER_NOEC(vector, 235)
TRAPHANDLER_NOEC(vector, 236)
TRAPHANDLER_NOEC(vector, 237)
TRAPHANDLER_NOEC(vector, 238)
TRAPHANDLER_NOEC(vector, 239)
TRAPHANDLER_NOEC(vector, 240)
TRAPHANDLER_NOEC(vector, 241)
TRAPHANDLER_NOEC(vector, 242)
TRAPHANDLER_NOEC(vector, 243)
TRAPHANDLER_NOEC(vector, 244)
TRAPHANDLER_NOEC(vector, 245)
TRAPHANDLER_NOEC(vector, 246)
TRAPHANDLER_NOEC(vector, 247)
TRAPHANDLER_NOEC(vector, 248)
TRAPHANDLER_NOEC(vector, 249)
TRAPHANDLER_NOEC(vector, 250)
TRAPHANDLER_NOEC(vector, 251)
TRAPHANDLER_NOEC(vector, 252)
TRAPHANDLER_NOEC(vector, 253)
TRAPHANDLER_NOEC(vector, 254)
TRAPHANDLER_NOEC(vector, 255)



/*
 * Lab 3: Your code here for _alltraps
 */
.globl _alltraps
_alltraps:
	pushl %ds
	pushl %es
	pushal

	# load the data segment
	movw $GD_KD, %ax
	movw %ax, %ds
	movw %ax, %es

	# call trap(tf), where tf = %esp
	pushl %esp
	call trap
	add $4, %esp

# Return falls through to trapret... but now it never return
#.globl trapret
#trapret:
#    popal
#    popl %es
#    popl %ds
#    addl $0x8, %esp  # trapno and errcode
#    iret

# vector table
.data
.globl vectors
vectors:
  .long vector0
  .long vector1
  .long vector2
  .long vector3
  .long vector4
  .long vector5
  .long vector6
  .long vector7
  .long vector8
  .long vector9
  .long vector10
  .long vector11
  .long vector12
  .long vector13
  .long vector14
  .long vector15
  .long vector16
  .long vector17
  .long vector18
  .long vector19
  .long vector20
  .long vector21
  .long vector22
  .long vector23
  .long vector24
  .long vector25
  .long vector26
  .long vector27
  .long vector28
  .long vector29
  .long vector30
  .long vector31
  .long vector32
  .long vector33
  .long vector34
  .long vector35
  .long vector36
  .long vector37
  .long vector38
  .long vector39
  .long vector40
  .long vector41
  .long vector42
  .long vector43
  .long vector44
  .long vector45
  .long vector46
  .long vector47
  .long vector48
  .long vector49
  .long vector50
  .long vector51
  .long vector52
  .long vector53
  .long vector54
  .long vector55
  .long vector56
  .long vector57
  .long vector58
  .long vector59
  .long vector60
  .long vector61
  .long vector62
  .long vector63
  .long vector64
  .long vector65
  .long vector66
  .long vector67
  .long vector68
  .long vector69
  .long vector70
  .long vector71
  .long vector72
  .long vector73
  .long vector74
  .long vector75
  .long vector76
  .long vector77
  .long vector78
  .long vector79
  .long vector80
  .long vector81
  .long vector82
  .long vector83
  .long vector84
  .long vector85
  .long vector86
  .long vector87
  .long vector88
  .long vector89
  .long vector90
  .long vector91
  .long vector92
  .long vector93
  .long vector94
  .long vector95
  .long vector96
  .long vector97
  .long vector98
  .long vector99
  .long vector100
  .long vector101
  .long vector102
  .long vector103
  .long vector104
  .long vector105
  .long vector106
  .long vector107
  .long vector108
  .long vector109
  .long vector110
  .long vector111
  .long vector112
  .long vector113
  .long vector114
  .long vector115
  .long vector116
  .long vector117
  .long vector118
  .long vector119
  .long vector120
  .long vector121
  .long vector122
  .long vector123
  .long vector124
  .long vector125
  .long vector126
  .long vector127
  .long vector128
  .long vector129
  .long vector130
  .long vector131
  .long vector132
  .long vector133
  .long vector134
  .long vector135
  .long vector136
  .long vector137
  .long vector138
  .long vector139
  .long vector140
  .long vector141
  .long vector142
  .long vector143
  .long vector144
  .long vector145
  .long vector146
  .long vector147
  .long vector148
  .long vector149
  .long vector150
  .long vector151
  .long vector152
  .long vector153
  .long vector154
  .long vector155
  .long vector156
  .long vector157
  .long vector158
  .long vector159
  .long vector160
  .long vector161
  .long vector162
  .long vector163
  .long vector164
  .long vector165
  .long vector166
  .long vector167
  .long vector168
  .long vector169
  .long vector170
  .long vector171
  .long vector172
  .long vector173
  .long vector174
  .long vector175
  .long vector176
  .long vector177
  .long vector178
  .long vector179
  .long vector180
  .long vector181
  .long vector182
  .long vector183
  .long vector184
  .long vector185
  .long vector186
  .long vector187
  .long vector188
  .long vector189
  .long vector190
  .long vector191
  .long vector192
  .long vector193
  .long vector194
  .long vector195
  .long vector196
  .long vector197
  .long vector198
  .long vector199
  .long vector200
  .long vector201
  .long vector202
  .long vector203
  .long vector204
  .long vector205
  .long vector206
  .long vector207
  .long vector208
  .long vector209
  .long vector210
  .long vector211
  .long vector212
  .long vector213
  .long vector214
  .long vector215
  .long vector216
  .long vector217
  .long vector218
  .long vector219
  .long vector220
  .long vector221
  .long vector222
  .long vector223
  .long vector224
  .long vector225
  .long vector226
  .long vector227
  .long vector228
  .long vector229
  .long vector230
  .long vector231
  .long vector232
  .long vector233
  .long vector234
  .long vector235
  .long vector236
  .long vector237
  .long vector238
  .long vector239
  .long vector240
  .long vector241
  .long vector242
  .long vector243
  .long vector244
  .long vector245
  .long vector246
  .long vector247
  .long vector248
  .long vector249
  .long vector250
  .long vector251
  .long vector252
  .long vector253
  .long vector254
  .long vector255
