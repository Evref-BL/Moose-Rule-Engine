Class {
	#name : 'MRETestParentPreset',
	#superclass : 'MRERulePreset',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'accessing' }
MRETestParentPreset class >> parentPresets [

	^ {  }
]

{ #category : 'accessing' }
MRETestParentPreset class >> presetName [

	^ 'mre-test-parent'
]

{ #category : 'accessing' }
MRETestParentPreset class >> rules [

	^ { MRETestRuleOne }
]
