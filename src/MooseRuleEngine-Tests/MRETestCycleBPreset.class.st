Class {
	#name : 'MRETestCycleBPreset',
	#superclass : 'MRERulePreset',
	#category : 'MooseRuleEngine-Tests',
	#package : 'MooseRuleEngine-Tests'
}

{ #category : 'accessing' }
MRETestCycleBPreset class >> parentPresetNames [

	^ #( 'mre-test-cycle-a' )
]

{ #category : 'accessing' }
MRETestCycleBPreset class >> presetName [

	^ 'mre-test-cycle-b'
]
