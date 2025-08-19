"
A MRERemediationTest is a test class for testing the behavior of MRERemediation
"
Class {
	#name : 'MRERemediationTest',
	#superclass : 'TestCase',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'tests' }
MRERemediationTest >> testHasConflictWith [
	| file1 fixA1 remediationA file2 fixB1 remediationB |
	file1 := MREFile new path: '/file1'.
	fixA1 := MREFix new startPos: 10; endPos: 20; file: file1.
	
	remediationA := MRERemediation new fixes: { fixA1 }.
	
	file2 := MREFile new path: '/file2'.
	fixB1 := MREFix new startPos: 10; endPos: 20; file: file2.
	
	remediationB := MRERemediation new fixes: { fixB1 }.
	
	self deny: (remediationA hasConflictWith: remediationB).
	
	
]

{ #category : 'tests' }
MRERemediationTest >> testHasConflictWithMultipleFixNoConflict [
	| file1 fixA1 remediationA fixB1 remediationB fixA2 fixB2 |
	file1 := MREFile new path: '/file1'.
	
	fixA1 := MREFix new startPos: 10; endPos: 20; file: file1.	
	remediationA := MRERemediation new fixes: { fixA1 }.
	fixA2 := MREFix new startPos: 30; endPos: 40; file: file1.	
	remediationA := MRERemediation new fixes: { fixA1 . fixA2 }.
	
	fixB1 := MREFix new startPos: 50; endPos: 60; file: file1.	
	fixB2 := MREFix new startPos: 70; endPos: 80; file: file1.	
	remediationB := MRERemediation new fixes: { fixB1 . fixB2 }.
	
	 self deny: (remediationA hasConflictWith: remediationB).
	
	
]

{ #category : 'tests' }
MRERemediationTest >> testHasConflictWithMultipleFixOneConflict [
	| file1 fixA1 remediationA fixB1 remediationB fixA2 fixB2 |
	file1 := MREFile new path: '/file1'.
	
	fixA1 := MREFix new startPos: 10; endPos: 20; file: file1.	
	remediationA := MRERemediation new fixes: { fixA1 }.
	fixA2 := MREFix new startPos: 30; endPos: 40; file: file1.	
	remediationA := MRERemediation new fixes: { fixA1 . fixA2 }.
	
	fixB1 := MREFix new startPos: 15; endPos: 25; file: file1.	
	fixB2 := MREFix new startPos: 35; endPos: 45; file: file1.	
	remediationB := MRERemediation new fixes: { fixB1 . fixB2 }.
	
	 self assert: (remediationA hasConflictWith: remediationB).
	
	
]

{ #category : 'tests' }
MRERemediationTest >> testHasConflictWithOneFixConflicts [
	| file1 fixA1 remediationA fixB1 remediationB |
	file1 := MREFile new path: '/file1'.
	
	fixA1 := MREFix new startPos: 10; endPos: 20; file: file1.	
	remediationA := MRERemediation new fixes: { fixA1 }.
	
	fixB1 := MREFix new startPos: 15; endPos: 25; file: file1.	
	remediationB := MRERemediation new fixes: { fixB1 }.
	
	 self assert: (remediationA hasConflictWith: remediationB).
	
	
]
