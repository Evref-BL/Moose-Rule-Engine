Class {
	#name : #MRELLMHelper,
	#superclass : #MREHelper,
	#instVars : [
		'llmApi'
	],
	#category : #MooseRuleEngine
}

{ #category : #'as yet unclassified' }
MRELLMHelper >> basePrompt [

	^'You can only answer with code. You can not talk ! Only give me the code in a simple code block without any explanation like that : ``` the modified code ```. Do not add comment in the code. Keep existing comment. Keep the same indentation and format'
]

{ #category : #utilities }
MRELLMHelper >> cleanLLMOutput: output [

	| cleanOutput |
	cleanOutput := output trim.
	cleanOutput := cleanOutput removePrefix: 'java'.
	cleanOutput := cleanOutput removePrefix: '```'.
	cleanOutput := cleanOutput removePrefix: 'java'.
	cleanOutput := cleanOutput removePrefix: '```'.
	cleanOutput := cleanOutput removePrefix: '`'.
	cleanOutput := cleanOutput removeSuffix: '```'.
	cleanOutput := cleanOutput removeSuffix: '`'.
	^ cleanOutput trim
]

{ #category : #'fix - static' }
MRELLMHelper >> fix: violation [

	| entities |
	
	llmApi payload
		temperature: 0.5;
		model: 'mistral-small-latest';
		top_p: 1;
		max_tokens: 1000.

	entities := violation entities.

	^ entities collect: [ :entity |
		  | prompt answer |
		  prompt := self basePrompt , Character lf asString , '``` '
		            , entity value , ' ``` ' , Character lf asString
		            , violation rule description.

		  llmApi payload messages:
			  { (LLMAPIChatObjectMessage role: 'user' content: prompt) }.
		  answer := llmApi performRequest.
		  answer := self cleanLLMOutput: answer.

		  MREFix new
			  file: entity file;
			  startPos: entity startPos;
			  endPos: entity endPos;
			  content: answer ]
]

{ #category : #'fix - static' }
MRELLMHelper >> fix: string withMessage: message [
	
	| prompt answer |
	llmApi payload
		temperature: 0.5;
		model: 'mistral-small-latest';
		top_p: 1;
		max_tokens: 1000.

		  prompt := self basePrompt , Character lf asString , '``` '
		            , string , ' ``` ' , Character lf asString
		            , message.

		  llmApi payload messages:
			  { (LLMAPIChatObjectMessage role: 'user' content: prompt) }.
		  answer := llmApi performRequest.
		  ^answer := self cleanLLMOutput: answer.

]

{ #category : #accessing }
MRELLMHelper >> llmApi [

	^ llmApi
]

{ #category : #accessing }
MRELLMHelper >> llmApi: anObject [

	llmApi := anObject
]

{ #category : #accessing }
MRELLMHelper >> name [

	^ 'llm'
]
