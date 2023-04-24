//
// nounAsVerb.h
//

// Uncomment to enable debugging options.
//#define __DEBUG_NOUN_AS_VERB

// Macro to help defining nouns-as-verbs.
// Args are, in order, the name for the verb and the class of objects
// it will apply to.
// Ex:  DefineNounAsVerb(Foozle, Pebble) will create FoozleAction, which
// will be called whenever the name of an instance of Pebble is typed by
// itself on the command line.
#ifndef DefineNounAsVerb

#define DefineNounAsVerb(name, cls) \
	DefineTActionSub(name, NounAsVerb); \
	VerbRule(name) singleDobj: name##Action \
	verbPhrase = 'fake/faking (what)' \
	nounAsVerbClass = cls

#endif // DefineNounAsVerb

// Don't comment out, used for dependency checking.
#ifndef NOUN_AS_VERB_H
#define NOUN_AS_VERB_H
#endif // NOUN_AS_VERB_H
