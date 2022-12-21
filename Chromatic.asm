ORG 0
ChromaticScale:
	LOAD Ab2
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD A2
	OUT Audio
	CALL EigthNoteDelay

	LOAD Bb2
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD B2
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD C3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Db3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD D3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Eb3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD E3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD F3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Gb3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD G3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Ab3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD A3
	OUT Audio
	CALL EigthNoteDelay

	LOAD Bb3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD B3
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD C4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Db4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD D4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Eb4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD E4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD F4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Gb4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD G4
	OUT Audio
	CALL EigthNoteDelay

	LOAD Ab4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD A4
	OUT Audio
	CALL EigthNoteDelay

	LOAD Bb4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD B4
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD C5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Db5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD D5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Eb5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD E5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD F5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Gb5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD G5
	OUT Audio
	CALL EigthNoteDelay

	LOAD Ab5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD A5
	OUT Audio
	CALL EigthNoteDelay

	LOAD Bb5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD B5
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD C6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Db6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD D6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Eb6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD E6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD F6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Gb6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD G6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Ab6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD A6
	OUT Audio
	CALL EigthNoteDelay

	LOAD Bb6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD B6
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD C7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Db7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD D7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Eb7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD E7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD F7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Gb7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD G7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Ab7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD A7
	OUT Audio
	CALL EigthNoteDelay

	LOAD Bb7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD B7
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD C8
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Db8
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD D8
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD Eb8
	OUT Audio
	CALL EigthNoteDelay
	
	LOAD F4
	OUT AUDIO
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	
	
	LOAD C5
	OUT AUDIO
	CALL QuarterNoteDelay
	
	LOAD Bb4
	OUT AUDIO
	CALL EigthNoteDelay
	
	
	LOAD Ab4
	OUT AUDIO
	Call QuarterNoteDelay
	
	LOAD Bb4
	OUT AUDIO
	CALL EigthNoteDelay
	
	LOAD C5
	OUT AUDIO
	Call QuarterNoteDelay
	
	LOAD F4
	OUT AUDIO
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	
	Load C5
	OUT AUDIO
	Call QuarterNoteDelay
	
	Load Bb4 
	OUT AUDIO
	CALL EigthNoteDelay
	
	Load Ab4
	OUT AUDIO
	Call QuarterNoteDelay
	
	LOAD G4
	OUT AUDIO
	Call QuarterNoteDelay
	
	LOAD F4 
	OUT AUDIO
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	CALL QuarterNoteDelay
	
	JUMP ChromaticScale







EigthNoteDelay:
	OUT Timer
EigthLoop:
	IN     Timer
	ADDI   -5
	JNEG   EigthLoop
	RETURN
	
QuarterNoteDelay:
	OUT Timer
QuarterLoop:
    IN     Timer
	ADDI   -10
	JNEG   QuarterLoop
	RETURN
	
	
; IO address constants
Audio:     EQU 064
Timer:     EQU 002

Ab2: dW 1024
A2: dw 1025
Bb2: dw 1026
B2: dw 1027
C3: dw 1028
Db3: dw 1029
D3: dw 1030
Eb3: dw 1031
E3: dw 1032
F3: dw 1033
Gb3: dw 1034
G3: dw 1035
Ab3: dw 1040
A3: dw 1041
Bb3: dw 1042
B3: dw 1043
C4: dw 1044
Db4: dw 1045
D4: dw 1046
Eb4: dw 1047
E4: dw 1048
F4: dw 1049
Gb4: dw 1050
G4: dw 1051
Ab4: dw 1056
A4: dw 1057
Bb4: dw 1058
B4: dw 1059
C5: dw 1060
Db5: dw 1061
D5: dw 1062
Eb5: dw 1063
E5: dw 1064
F5: dw 1065
Gb5: dw 1066
G5: dw 1067
Ab5: dw 1072
A5: dw 1073
Bb5: dw 1074
B5: dw 1075
C6: dw 1076
Db6: dw 1077
D6: dw 1078
Eb6: dw 1079
E6: dw 1080
F6: dw 1081
Gb6: dw 1082
G6: dw 1083
Ab6: dw 1088
A6: dw 1089
Bb6: dw 1090
B6: dw 1091
C7: dw 1092
Db7: dw 1093
D7: dw 1094
Eb7: dw 1095
E7: dw 1096
F7: dw 1097
Gb7: dw 1098
G7: dw 1099
Ab7: dw 1104
A7: dw 1105
Bb7: dw 1106
B7: dw 1107
C8: dw 1108
Db8: dw 1109
D8: dw 1110
Eb8: dw 1111