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

#include "nounAsVerb.h"

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
		&gt;PEBBLE will call FooAction on the pebble.
		<.p>
		&gt;ROCK will call BarAction on the rock.
		<.p>
		&gt;STONE will fall through and behave as if the module wasn't
		in use.
		<.p>
		Consult the README.txt document distributed with the library
		source for a quick summary of how to use the library in your
		own games.
		<.p>
		The library source is also extensively commented in a way
		intended to make it as readable as possible. ";
	}
;

// Define a FooAction that matches the name of any Pebble instance typed
// by itself on the command line.
DefineNounAsVerb(Foo, Pebble);

// Same as above, only it's BarAction that applies to instances of Rock.
DefineNounAsVerb(Bar, Rock);

// Default handlers for our actions.  This is almost certainly
// superfluous--there's no situation in which a generic Thing should
// be the direct object of either FooAction or BarAction.
modify Thing
	dobjFor(Foo) { verify() { illogical('You can\'t foo that.'); } }
	dobjFor(Bar) { verify() { illogical('You can\'t bar that.'); } }
;

// Handler on Pebble for the "foo" action.
class Pebble: Thing
	dobjFor(Foo) {
		verify() { nonObvious; }
		action() { "You foo the pebble. "; }
	}
;

// Handler on Rock for the "bar" action.
class Rock: Thing
	dobjFor(Bar) {
		verify() { nonObvious; }
		action() { "You bar the rock. "; }
	}
;

// A threadbare game world.  It contains a pebble that will respond
// to >PEBBLE by applying the "foo" action to the pebble, to >ROCK
// by applying the "bar" action to the rock, and >STONE as if none
// of the noun-to-verb was there.
startRoom: Room 'Void' "This is a featureless void. ";
+me: Person;
+pebble: Pebble 'small round pebble' 'pebble' "A small, round pebble. ";
+rock: Rock 'ordinary rock' 'rock' "An ordinary rock. ";
+stone: Thing 'nondescript stone' 'stone' "A nondescript stone. ";

gameMain:       GameMainDef initialPlayerChar = me;
