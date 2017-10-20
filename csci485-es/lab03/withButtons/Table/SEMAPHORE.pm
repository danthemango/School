package Table::SEMAPHORE;
#================================================================--
# File Name    : Table/SEMAPHORE.pm
#
# Purpose      : table of Semaphore records
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

$| = 1;
use strict;
use warnings;

use Record::Semaphore;
use Exc::Exception;

my %table;

sub get_keys {

   return keys(%table);
}

sub add {
   my $pkg = shift @_;
   my %params = @_;

   if (defined($params{name})) {
      if (!exists($table{$params{name}})) {
         $table{$params{name}} = Record::Semaphore->new();
      } else {
         die(Exc::Exception->new(name => "Table::SEMAPHORE->add name duplicate"));
      }
   } else {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->add name undefined"));
   }

   if (defined($params{value})) {
      $table{$params{name}}->set_value($params{value});
   }

   if (defined($params{max})) {
      $table{$params{name}}->set_max($params{max});
   }

}

sub get_value {
   my $pkg = shift @_;
   my $name = shift @_;

   if (!defined($name)) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->get_value name undefined"));
   }

   if (!exists($table{$name})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->get_value name = $name not in table"));
   }

   return ($table{$name}->get_value());
}

sub get_max {
   my $pkg = shift @_;
   my $name = shift @_;

   if (!defined($name)) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->get_max name undefined"));
   }

   if (!exists($table{$name})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->get_max name = $name not in table"));
   }

   return ($table{$name}->get_max());
}

sub set_value {
   my $pkg = shift @_;
   my $name = shift @_;
   my $v = shift @_;

   if (!defined($name)) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->set_value name undefined"));
   }

   if (!exists($table{$name})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->set_value name = $name not in table"));
   }

   $table{$name}->set_value($v);
}

sub wait {
   my $pkg = shift @_;
   my %params = @_;

   if (!defined($params{semaphore})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->wait sem name undefined"));
   }

   if (!exists($table{$params{semaphore}})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->wait name = sem name not in table"));
   }

   if (!defined($params{task})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->wait task undefined"));
   }

   $table{$params{semaphore}}->wait($params{task});
}

sub signal {
   my $pkg = shift @_;
   my %params = @_;

   if (!defined($params{semaphore})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->wait sem undefined"));
   }

   if (!exists($table{$params{semaphore}})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->signal sem not in table"));
   }

   $table{$params{semaphore}}->signal();
}

sub increment_elapsedTime {
   my $pkg = shift @_;
   my $name = shift @_;

   if (!defined($name)) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->increment_elapsedTime name undefined"));
   }

   if (!exists($table{$name})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->increment_elapsedTime name $name not in table"));
   }

   my $t = $table{$name}->get_elapsedTime();
   $table{$name}->set_elapsedTime($t+1);
}

sub clear_elapsedTime {
   my $pkg = shift @_;
   my $name = shift @_;

   if (!defined($name)) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->clear_elapsedTime name undefined"));
   }

   if (!exists($table{$name})) {
      die(Exc::Exception->new(name => "Table::SEMAPHORE->clear_elapsedTime name $name not in table"));
   }

   $table{$name}->set_elapsedTime(0);
}


sub dump {
   my $self = shift @_;

   my $key;

   foreach $key (keys(%table)) {
      print ("Name: $key \n");
      $table{$key}->dump();
      print ("\n");
   } 
}

1;
