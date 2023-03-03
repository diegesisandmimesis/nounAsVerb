#charset "us-ascii"
//
// nameAsExamine.t
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
		&gt;PEBBLE will call ExamineAction on the pebble.
		<.p>
		Consult the README.txt document distributed with the library
		source for a quick summary of how to use the library in your
		own games.
		<.p>
		The library source is also extensively commented in a way
		intended to make it as readable as possible. ";
	}
;

DefineNounAsVerb(NounAsExamine, Thing);

modify Thing
	dobjFor(NounAsExamine) asDobjFor(Examine)
;

startRoom: Room 'Void' "This is a featureless void. ";
+me: Person;
+pebble: Thing 'small round pebble' 'pebble' "A small, round pebble. ";

gameMain:       GameMainDef initialPlayerChar = me;
