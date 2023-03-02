#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the nounAsVerb library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

versionInfo:    GameID
        name = 'nounAsVerb Library Demo Game'
        byline = 'Diegesis & Mimesis'
        desc = 'Demo game for the nounAsVerb library. '
        version = '1.0'
        IFID = '12345'
	showAbout() {
		"This is a simple test game that demonstrates the features
		of the nounAsVerb library.
		<.p>
		Consult the README.txt document distributed with the library
		source for a quick summary of how to use the library in your
		own games.
		<.p>
		The library source is also extensively commented in a way
		intended to make it as readable as possible. ";
	}
;

DefineTAction(Foo);
VerbRule(Foo) singleDobj: FooAction verbPhrase = 'foo/fooing (what)'
	nounAsVerbClass = Pebble
	resolveNouns(srcActor, dstActor, results) {
		inherited(srcActor, dstActor, results);
		resolveNounsAsVerbs(srcActor, dstActor, results);
	}
;

DefineTAction(Bar);
VerbRule(Bar) singleDobj: BarAction verbPhrase = 'bar/barring (what)'
	nounAsVerbClass = Rock
	resolveNouns(srcActor, dstActor, results) {
		inherited(srcActor, dstActor, results);
		if(rexMatch('rock', dobjMatch.getOrigText()) == nil)
			results.noteWeakPhrasing(100);
	}
;

modify Thing
	dobjFor(Foo) { verify() { illogical('You can\'t foo that.'); } }
	dobjFor(Bar) { verify() { illogical('You can\'t bar that.'); } }
;

class Pebble: Thing
	dobjFor(Foo) {
		verify() { nonObvious; }
		action() { "You foo the pebble. "; }
	}
;

class Rock: Thing
	dobjFor(Bar) {
		verify() { nonObvious; }
		action() { "You bar the rock. "; }
	}
;


startRoom: Room 'Void' "This is a featureless void. ";
+me: Person;
+pebble: Pebble 'small round pebble' 'pebble' "A small, round pebble. ";
+rock: Rock 'ordinary rock' 'rock' "An ordinary rock. ";
+stone: Thing 'nondescript stone' 'stone' "A nondescript stone. ";

versionInfo: GameID;
gameMain:       GameMainDef initialPlayerChar = me;
