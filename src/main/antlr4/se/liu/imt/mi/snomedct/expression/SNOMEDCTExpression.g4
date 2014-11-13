grammar SNOMEDCTExpression;

options {
	language = Java;
}

//tokens {
//	TOP_AND,
//	AND,
//	GENUS,
//	DIFF,
//	ROLEGROUP,
//	SOME,
//	CONCEPT,
//	UNION,
//	DESC,
//	DESC_SELF,
//	ALL
//}

statement
:
	'(' subExpression ')' definitionStatus '(' subExpression ')'
;

expression
:
	definitionStatus subExpression
	| subExpression
;

definitionStatus
:
	EQ_TO
	| SC_OF
;

subExpression
:
	focusConcept
	(
		':' refinement
	)?
;

focusConcept
:
	conceptReference
	(
		'+' conceptReference
	)*
;

conceptReference
:
	SCTID
	| SCTID TERM
;

refinement
:
	attributeSet
	(
		',' attributeGroup
	)*
	| attributeGroup
	(
		',' attributeGroup
	)*
;

attributeGroup
:
	'{' attributeSet '}'
;

attributeSet
:
	attribute
	(
		',' attribute
	)*
;

attribute
:
	attributeType = conceptReference '=' attributeValue
;

attributeValue
:
	conceptReference
	| nestedExpression
	| NUMBER
	| STRING
;

nestedExpression
:
	'(' subExpression ')'
;

NUMBER
:
	'#' '-'? NONZERO DIGIT*
	(
		'.' DIGIT*
	)?
	| '#' '-'? '0.' DIGIT+
;

STRING
:
	'"'
	(
		ESCAPE_CHAR
		| ~( '"' | '\\' )
	)*? '"'
;

fragment
ESCAPE_CHAR
:
	'\\"'
	| '\\\\'
;

TERM
:
	'|' ' '* NONWSNONPIPE
	(
		' '
		| NONWSNONPIPE
	)* '|'
;

SCTID
:
	'-'? NONZERO DIGIT*
;

EQ_TO
:
	'==='
;

SC_OF
:
	'<<<'
;

fragment
DIGIT
:
	'0' .. '9'
;

fragment
NONZERO
:
	'1' .. '9'
;

fragment
NONWSNONPIPE
:
	~( '|' | '\t' | ' ' | '\r' | '\n' | '\u000C' )
;

WS
:
	(
		'\t'
		| ' '
		| '\r'
		| '\n'
		| '\u000C'
	) -> skip
;

  
