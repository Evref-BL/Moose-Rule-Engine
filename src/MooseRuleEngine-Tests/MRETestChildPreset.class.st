Class {
	#name : 'MRETestChildPreset',
	#superclass : 'MRERulePreset',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'accessing' }
MRETestChildPreset class >> parentPresetNames [

	^ #( 'mre-test-parent' )
]

{ #category : 'accessing' }
MRETestChildPreset class >> presetName [

	^ 'mre-test-child'
]

{ #category : 'accessing' }
MRETestChildPreset class >> ruleNames [

	^ #( 'MRETestRuleOne' 'MRETestRuleTwo' )
]
