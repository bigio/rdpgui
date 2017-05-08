#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Tk;

# Main Window
my $mw = new MainWindow;

# GUI Building Area
my $frm = $mw->Frame();

# Selection
my $lst = $frm->Listbox(-selectmode=>'single',-width=>50);

# Listbox
$lst->insert('end', "test.tld:port|Administrator");

my $but = $mw->Button(-text=>"Connect", -command =>\&push_button);

# Geometry Management
$lst->grid(-row=>2,-column=>1);
$frm->grid(-row=>2,-column=>2);
$but->grid(-row=>4,-column=>1,-columnspan=>2);

MainLoop;

# This function will be executed when the button is pushed
sub push_button {
	my $name = $lst->get('active');
	print Dumper $name;
}
