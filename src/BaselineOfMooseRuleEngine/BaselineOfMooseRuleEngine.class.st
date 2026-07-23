Class {
	#name : 'BaselineOfMooseRuleEngine',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMooseRuleEngine',
	#package : 'BaselineOfMooseRuleEngine'
}

{ #category : 'baselines' }
BaselineOfMooseRuleEngine >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'dependencies' }
BaselineOfMooseRuleEngine >> defineDependencies: spec [

	spec
		baseline: 'Mocketry'
		with: [ spec repository: 'github://dionisiydk/Mocketry:v7.0.3' ].

	spec
		baseline: 'LLMAPI'
		with: [ spec repository: 'github://Evref-BL/Pharo-LLMAPI:1.0.4/src' ].

	spec
		baseline: 'SonarqubePharoAPI'
		with: [
		spec repository: 'github://Evref-BL/Sonarqube-Pharo-API:0.1.0' ].

	spec baseline: 'FASTJava' with: [
		spec
			repository: 'github://moosetechnology/FAST-Java:v4/src';
			loads: #( 'smacc' ) ]
]

{ #category : 'groups' }
BaselineOfMooseRuleEngine >> defineGroups: spec [

	
]

{ #category : 'packages' }
BaselineOfMooseRuleEngine >> definePackages: spec [

	spec
		package: 'MooseRuleEngine'
		with: [ spec requires: #( 'LLMAPI' 'SonarqubePharoAPI' ) ].
	spec
		package: 'MooseRuleEngine-Tests'
		with: [ spec requires: #( 'MooseRuleEngine' 'Mocketry' 'FASTJava' ) ]
]
