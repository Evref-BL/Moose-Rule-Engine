"
I am a rule whose fix: raises, like a rule that does not find the node at the reported position.
"
Class {
	#name : 'RuleMockFixError',
	#superclass : 'MRERule',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'running' }
RuleMockFixError >> analyse: file [

	^ MREViolation new
		  rule: self;
		  addEntity: (MREEntity new
				   file: file;
				   startPos: 1;
				   endPos: 3;
				   yourself);
		  yourself
]

{ #category : 'running' }
RuleMockFixError >> fix: violation [

	^ self error: 'no node at this position'
]

{ #category : 'accessing' }
RuleMockFixError >> supportedExtensions [

	^ #( 'ts' )
]
