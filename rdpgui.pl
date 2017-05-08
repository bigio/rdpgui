#!/usr/bin/perl

#------------------------------------------------------------------------------
# Copyright (c) 2017, Giovanni Bechis
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#------------------------------------------------------------------------------

use strict;
use warnings;

use Data::Dumper;
use Tk;

my $cont_rdpfile;
my $rdpfile = $ENV{"HOME"} . "/.rdpgui.db";

# Main Window
my $mw = new MainWindow;

# GUI Building Area
my $frm = $mw->Frame();

# Selection
my $lst = $frm->Listbox(-selectmode=>'single',-width=>50);

# Populate listbox from file
open(my $fh, $rdpfile) or die "Can't open $rdpfile: $!";
while ( ! eof($fh) ) {
	defined( $_ = <$fh> )
	or die "readline failed for $rdpfile: $!";
	chomp();
	$cont_rdpfile = $_;

	$lst->insert('end', $cont_rdpfile);
}
close($fh);

my $but = $mw->Button(-text=>"Connect", -command =>\&push_button);

# Geometry Management
$lst->grid(-row=>2,-column=>1);
$frm->grid(-row=>2,-column=>2);
$but->grid(-row=>4,-column=>1,-columnspan=>2);

MainLoop;

# This function will be executed when the button is pushed
sub push_button {
	my $name = $lst->get('active');
	my ($host, $user) = split(/\|/, $name);
	system("xfreerdp /size:1280x715 /u:$user /sec:rdp /clipboard:1 /compression:1 /printer:1 /v:$host &");
	exit;
}
