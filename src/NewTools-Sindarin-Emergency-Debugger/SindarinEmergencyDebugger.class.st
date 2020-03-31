"
I am a REPL debugger and I provide an access to the Sindarin debugging API.
I do not depend on morphic, and while I depend on Color, I can work without it.

I use a ReadWriteStream to handle user input and output my results.
I use Display and DisplayScreen to show my results.
"
Class {
	#name : #SindarinEmergencyDebugger,
	#superclass : #Object,
	#instVars : [
		'sindarinDebugger',
		'rwStream',
		'rawDisplay',
		'stackSelectionIndex'
	],
	#category : #'NewTools-Sindarin-Emergency-Debugger'
}

{ #category : #accessing }
SindarinEmergencyDebugger class >> displayStackSize [
	^10
]

{ #category : #initialization }
SindarinEmergencyDebugger >> initialize [
	rwStream := SEDReadWriteStream forDebugger: self.
	rawDisplay := SEDDisplayInterface new.
	stackSelectionIndex := 1
]