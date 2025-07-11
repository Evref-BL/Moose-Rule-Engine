Class {
	#name : 'BaselineOfMooseRuleEngine',
	#superclass : 'Object',
	#category : 'MooseRuleEngine',
	#package : 'MooseRuleEngine'
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
    with: [ spec repository: 'github://dionisiydk/Mocketry' ]
]

{ #category : 'groups' }
BaselineOfMooseRuleEngine >> defineGroups: spec [
]

{ #category : 'packages' }
BaselineOfMooseRuleEngine >> definePackages: spec [

	spec
		package: 'MooseRuleEngine'.
	spec package: 'MooseRuleEngine-Test' with: [ spec requires: #('MooseRuleEngine' 'Mocketry') ].
]
