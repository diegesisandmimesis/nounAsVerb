#charset "us-ascii"
//
// nounAsVerb.t
//
// This module provides a couple macros to make it easier to implement
// actions that are called by typing bare noun phrases on the command
// line.
//
// Example:
//
//	DefineNounAsVerb(NounAsExamine, Thing);
//	modify Thing dobjFor(NounAsExamine) asDobjFor(Examine);
//
// Then an object name typed by itself on the command line would be
// interpreted the same as >X [object name].
//
#include <adv3.h>
#include <en_us.h>

// Module ID for the library
nounAsVerbModuleID: ModuleID {
        name = 'Noun as Verb Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

class NounAsVerb: TAction
	// The class of objects, if any, this action applies to.
	nounAsVerbClass = nil

	// See if our dobjList_ contains any objects of the class
	// defined above.  If it doesn't, then we mark the results
	// as being a weak phrasing.  If there are other options
	// for the parser to pick from, it will prefer them over us.
	//
	resolveNounsAsVerbs(srcActor, dstActor, results) {
		local r;

		if((dobjList_ == nil) || (nounAsVerbClass == nil))
			return;

		r = nil;
		dobjList_.forEach(function(o) {
			if(o.obj_ && o.obj_.ofKind(nounAsVerbClass))
				r = true;
		});

		if(r != true)
			results.noteWeakPhrasing(100);
	}

	// We need to call resolveNounsAsVerbs() after inherited()
	// because the parent method is what will populate dobjList_.
	resolveNouns(srcActor, dstActor, results) {
		inherited(srcActor, dstActor, results);
		resolveNounsAsVerbs(srcActor, dstActor, results);
	}
;

// A kind of fallthrough action for our "verbed" noun logic.
// This will be picked by the parser if all the other noun-as-verb actions
// DID NOT match their nounAsVerbClass declarations.  That is, all the
// other actions marked themselves as weak phrasings, which means that
// all we have to do to be picked is to not be as weak as they are.
DefineTAction(NounAsVerbCatchAll);
VerbRule(NounAsVerbCatchAll)
	singleDobj: NounAsVerbCatchAllAction
	verbPhrase = 'catch/catching (what)'

	resolveNouns(srcActor, dstActor, results) {
		inherited(srcActor, dstActor, results);
		// We note a bad preposition.  Which is a complete
		// fabrication, but it will still have precedence over
		// actions that identified themselves as having weak phrasing,
		// and it won't throw an exception or anything.  This
		// should consistently cause the parser to drop us on
		// the floor, and handle the command as if none of
		// the noun-as-verb logic was defined.
		results.noteBadPrep();
	}
;
