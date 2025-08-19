"
A MREFixTest is a test class for testing the behavior of MREFix
"
Class {
	#name : 'MREFixTest',
	#superclass : 'TestCase',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'tests' }
MREFixTest >> testApplyOnFile [

	 | file fix result |
	 file :=MREFile new content: 'abcdefghi'.
    fix := MREFix new startPos: 3; endPos: 5; content: ''; file: file.

    result := fix applyOnFile.

    self assert: result equals: 'abfghi'.

]

{ #category : 'tests' }
MREFixTest >> testApplyOnFileOnFullReplacement [

	| file fix result |
	file := MREFile new content: 'abcdefghi'.
	fix := MREFix new
		       startPos: 1;
		       endPos: file content size;
		       content: 'a';
		       file: file.

	result := fix applyOnFile.

	self assert: result equals: 'a'
]

{ #category : 'tests' }
MREFixTest >> testApplyOnFileOnInsert [

	| file fix result |
	file := MREFile new content: 'abcdef'.
	fix := MREFix new
		       startPos: 4;
		       endPos: 4;
		       content: 'INSERT';
		       file: file.

	result := fix applyOnFile.

	self assert: result equals: 'abcINSERTdef'
]

{ #category : 'tests' }
MREFixTest >> testApplyOnFileOnReplacement [

	| file fix result |
	file := MREFile new content: 'abcdefghi'.
	fix := MREFix new
		       startPos: 1;
		       endPos: 3;
		       content: 'aaaaaaaaaaa';
		       file: file.

	result := fix applyOnFile.

	self assert: result equals: 'aaaaaaaaaaadefghi'
]

{ #category : 'tests' }
MREFixTest >> testEndLine [

	| file entity startLine |
	file := MREFile new
		        path: 'test.java';
		        content: 'aaaaa
	aaaaa
	aaaaa
	aaaaa'.

	entity := MREFix new
		          file: file;
		          endPos: 7.

	startLine := entity endLine.

	self assert: startLine equals: 2
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWith [

	| file1 fix1 file2 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 10; endPos: 20; file: file1.
	
	file2 := MREFile new path: '/file2'.
	fix2 := MREFix new startPos: 15; endPos: 25; file: file2.
	
	self assert: (fix1 hasConflictWith: fix2) equals: false.
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWithFix1BeforeFix2 [

	| file1 fix1 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 10; endPos: 20; file: file1.
	
	fix2 := MREFix new startPos: 21; endPos: 30; file: file1.
	
	self assert: (fix1 hasConflictWith: fix2) equals: false.
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWithFix1CompletelyInsideFix2 [

	| file1 fix1 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 15; endPos: 20; file: file1.
	
	fix2 := MREFix new startPos: 10; endPos: 25; file: file1.
	
	self assert: (fix1 hasConflictWith: fix2) equals: true.
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWithFix2BeforeFix1 [

	| file1 fix1 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 21; endPos: 30; file: file1.
	
	fix2 := MREFix new startPos: 10; endPos: 20; file: file1.
	
	self assert: (fix1 hasConflictWith: fix2) equals: false.
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWithFix2CompletelyInsideFix1 [

	| file1 fix1 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 10; endPos: 25; file: file1.
	
	fix2 := MREFix new startPos: 15; endPos: 20; file: file1.
	
	self assert: (fix1 hasConflictWith: fix2) equals: true.
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWithPartialOverlapAtEnd [

	| file1 fix1 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 15; endPos: 25; file: file1.
	
	fix2 := MREFix new startPos: 10; endPos: 20; file: file1.
	
	self assert: (fix1 hasConflictWith: fix2) equals: true.
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWithPartialOverlapAtStart [

	| file1 fix1 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 10; endPos: 20; file: file1.
	
	fix2 := MREFix new startPos: 15; endPos: 25; file: file1.
	
	self assert: (fix1 hasConflictWith: fix2) equals: true.
]

{ #category : 'tests' }
MREFixTest >> testHasConflictWithZeroLengthFix [

	| file1 fix1 fix2 |
	file1 := MREFile new path: '/file1'.
	fix1 := MREFix new startPos: 10; endPos: 10; file: file1.
	
	fix2 := MREFix new startPos: 10; endPos: 20; file: file1.
	
	self assert: (fix1 hasConflictWith: fix2) equals: false.
]

{ #category : 'tests' }
MREFixTest >> testNewLines [

	| file fix newLines |
	file := MREFile new content: 'aaaa
	aaaa
	aaaa
	aaaa'.

	fix := MREFix new
		       file: file;
		       startPos: 1;
		       endPos: 3;
		       content: 'bbbbbb'.

	newLines := fix newLines.

	self assert: newLines equals: 'bbbbbba', Character lf asString.
]

{ #category : 'tests' }
MREFixTest >> testNewLinesIfContentEmpty [

	| file fix newLines |
	file := MREFile new content: 'aaaa bbb aaa
	aaaa
	aaaa
	aaaa'.

	fix := MREFix new
		       file: file;
		       startPos: 6;
		       endPos: 8;
		       content: 'aaa'.

	newLines := fix newLines.

	self assert: newLines equals: 'aaaa aaa aaa', Character lf asString.
]

{ #category : 'tests' }
MREFixTest >> testNewLinesIfLineCreated [

	| file fix newLines |
	file := MREFile new content: 'aaaa
	aaaa
	aaaa
	aaaa'.

	fix := MREFix new
		       file: file;
		       startPos: 1;
		       endPos: 4;
		       content: 'bbb
bbb'.

	newLines := fix newLines.

	self assert: newLines equals: 'bbb', Character lf asString, 'bbb', Character lf asString.
]

{ #category : 'tests' }
MREFixTest >> testNewLinesIfLineRemoved [

	| file fix newLines |
	file := MREFile new content: 'aaaa
	aaaa
	aaaa
	aaaa'.

	fix := MREFix new
		       file: file;
		       startPos: 1;
		       endPos: 4;
		       content: ''.

	newLines := fix newLines.

	self assert: newLines equals: '', Character lf asString.
]

{ #category : 'tests' }
MREFixTest >> testStartLine [

	| file entity startLine |
	file := MREFile new
		        path: 'test.java';
		        content: 'aaaaa
	aaaaa
	aaaaa
	aaaaa'.

	entity := MREFix new
		          file: file;
		          startPos: 7.

	startLine := entity startLine.

	self assert: startLine equals: 2
]
