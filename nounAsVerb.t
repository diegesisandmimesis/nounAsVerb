#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

// Module ID for the library
nounAsVerbModuleID: ModuleID {
        name = 'Noun as Verb Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

modify Action
	nounAsVerbClass = nil

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
;

DefineTAction(NounAsVerbCatchAll);
VerbRule(NounAsVerbCatchAll)
	singleDobj: NounAsVerbCatchAllAction
	verbPhrase = 'catch/catching (what)'

	resolveNouns(srcActor, dstActor, results) {
		inherited(srcActor, dstActor, results);
		results.noteBadPrep();
	}
;
