package pc_Console::GUI;
#================================================================--
# File Name    : pc_Console/GUI.pm
#
# Purpose      : producer/consumer console GUI
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

use strict;
use warnings;
use Widgit::Light;
use Widgit::Sensor;
use constant FALSE => 0;
use constant TRUE => 1;
use Table::SVAR;

my @bl;

sub leaveScript {
   exit();
}


sub start {

   # create buffer window 

   my $bufferWindow = new Gtk2::Window "toplevel";
   $bufferWindow->set_title('Bounded Buffer');
   $bufferWindow->signal_connect( 'destroy' => sub {leaveScript();});
   $bufferWindow->set_resizable(FALSE);

   # create  buffer lights

   $bl[0]=Widgit::Light->new(header => "0");
   $bl[1]=Widgit::Light->new(header => "1");
   $bl[2]=Widgit::Light->new(header => "2");
   $bl[3]=Widgit::Light->new(header => "3");

   # create hbox and place  buffer lights  in hbox

   my $bufferHbox = Gtk2::HBox->new( FALSE, 4 );
   $bufferHbox->pack_start($bl[0]->get_canvas(),FALSE,FALSE,0);
   $bufferHbox->pack_start($bl[1]->get_canvas(),FALSE,FALSE,0);
   $bufferHbox->pack_start($bl[2]->get_canvas(),FALSE,FALSE,0);
   $bufferHbox->pack_start($bl[3]->get_canvas(),FALSE,FALSE,0);

   
   # create new button section
   my $buttonVbox = Gtk2::VBox->new(FALSE, 4);

   # and add buttons to toggle the consumer and producer
   # producer button
   my $producerButton = Widgit::Sensor->new(
      markup => "toggle Producer",
      cb => sub {
         if (Table::SVAR->get_value("sv_producer_enable")) {
             Table::SVAR->assign("sv_producer_enable", 0);
         } else {
            Table::SVAR->assign("sv_producer_enable", 1);
         }
         print("sv_producer_enable = " . Table::SVAR->get_value("sv_producer_enable") . "\n");
      }
   );

   # consumer button
   my $consumerButton = Widgit::Sensor->new(
      markup => "toggle Consumer",
      cb => sub {
         if (Table::SVAR->get_value("sv_consumer_enable")) {
            Table::SVAR->assign("sv_consumer_enable", 0);
         } else {
            Table::SVAR->assign("sv_consumer_enable", 1);
         }
         print("sv_consumer_enable = " . Table::SVAR->get_value("sv_consumer_enable") . "\n");
       }
   );

   # add buttons to button-section
   $buttonVbox->pack_start($producerButton->get_button(), TRUE, TRUE, 0);
   $buttonVbox->pack_start($consumerButton->get_button(), TRUE, TRUE, 0);

   # add button-section to main VBox
   $bufferHbox->pack_start($buttonVbox, FALSE, FALSE, 0);

   # put main VBox in window
   $bufferWindow->add($bufferHbox);

   # initialize buffer lights

   $bl[0]->set_light('gray');
   $bl[1]->set_light('gray');
   $bl[2]->set_light('gray');
   $bl[3]->set_light('gray');

   $bufferWindow->show_all;

}

 sub set_lights {
   my $class = shift @_;
   my @params = @_;
   $bl[0]->set_light($params[0]);
   $bl[1]->set_light($params[1]);
   $bl[2]->set_light($params[2]);
   $bl[3]->set_light($params[3]);


}

1;
