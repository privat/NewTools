Class {
	#name : #StInspector,
	#superclass : #StPresenter,
	#instVars : [
		'views',
		'evaluator',
		'model'
	],
	#classVars : [
		'PreferredExtent'
	],
	#category : #'NewTools-Inspector-View'
}

{ #category : #specs }
StInspector class >> defaultSpec [
	<spec: #default>
	
	^ SpecPanedLayout newVertical
		position: 70 percent;
		add: #views;
		add: #evaluator;
		yourself
]

{ #category : #accessing }
StInspector class >> defaultTitle [

	^ 'Inspector'
]

{ #category : #accessing }
StInspector class >> extensionsPragma [

	^ #inspectorPresentationOrder:
]

{ #category : #'tools registry' }
StInspector class >> inspect: anObject [
	self openOn: anObject
]

{ #category : #'instance creation' }
StInspector class >> openOn: anObject [

	^ (self on: (StInspectorModel on: anObject)) openWithSpec
]

{ #category : #accessing }
StInspector class >> preferredExtent [
	
	^ PreferredExtent ifNil: [ PreferredExtent := 600@400 ]
]

{ #category : #accessing }
StInspector class >> titleFor: anObject [ 

	^ 'Inspector on {1}' format: { anObject gtDisplayString  }
]

{ #category : #private }
StInspector >> allViews [
	
	^ { self model inspectedObject rawInspection }, self collectViews
]

{ #category : #private }
StInspector >> collectViews [

	^ self model objectInspections
]

{ #category : #api }
StInspector >> initialExtent [ 

	^ self class preferredExtent
]

{ #category : #initialization }
StInspector >> initializeWidgets [
	views := self newNotebook.
	evaluator := self newText
		beForCode;
		aboutToStyle: true;
		doItReceiver: self inspectedObject.
	self title: (self class titleFor: self inspectedObject).
	views
		pages:
			(self allViews
				collect: [ :each | 
					each owner: self.
					NotebookPage title: each title provider: [ each ] ])
]

{ #category : #initialization }
StInspector >> initializeWindow: aWindowPresenter [

	aWindowPresenter toolBar: self newToolBar
]

{ #category : #'model access' }
StInspector >> inspectedObject [ 	
	^self model inspectedObject
]

{ #category : #'model access' }
StInspector >> model [ 

	^ model
]

{ #category : #'model access' }
StInspector >> model: anInspectorModel [

	model := anInspectorModel.
	self refresh
]

{ #category : #'private factory' }
StInspector >> newToolBar [

	^ LtToolBarBuilder new 
		owner: self;
		matching: [ :each | each hasGroup: StInspectorCommandGroup uniqueInstance ];
		build
]

{ #category : #private }
StInspector >> refresh [
	"model changed?  
	 update inspector values."
	self flag: #TODO.
]

{ #category : #'model access' }
StInspector >> setModelBeforeInitialization: anInspectorModel [

	model := anInspectorModel

	
]