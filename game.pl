# copyright Guido Barosio, 2024
# see LICENSE 
use strict;
use warnings;

my $cash = 1000;  # Starting cash
my %inventory;    # Player's guitar inventory
my $guitar_price = 100;  # Starting price of guitars
my $turn = 0;

print "Welcome to the Guitar Trader Game!\n";

while (1) {
    print (`clear`);
    print "\nTurn: $turn\n";
    print "Cash: $cash\n";
    print "Guitar price this turn: $guitar_price\n";
    print "Your inventory: " . join(", ", map { "$_ x $inventory{$_}" } keys %inventory) . "\n";
    print "What would you like to do?\n";
    print "1. Buy a guitar\n";
    print "2. Sell a guitar\n";
    print "3. Exit\n";
    print "> ";
    
    my $choice = <STDIN>;
    chomp $choice;
    
    if ($choice == 1) {
        if ($cash < $guitar_price) {
            print "Not enough cash to buy a guitar!\n";
        } else {
            $cash -= $guitar_price;
            $inventory{$guitar_price}++;
            print "You bought a guitar for $guitar_price.\n";
        }
    } elsif ($choice == 2) {
        if (keys %inventory) {
            my @prices = sort { $a <=> $b } keys %inventory;
            my $sell_price = int($prices[-1] * 1.15); 
            if ($inventory{$prices[-1]}) {  # Make sure to use the original buy price to check inventory
                $inventory{$prices[-1]}--;
                $cash += $sell_price;
                print "You sold a guitar for $sell_price.\n";
                delete $inventory{$prices[-1]} unless $inventory{$prices[-1]};
            }
        } else {
            print "You have no guitars to sell!\n";
        }
    } elsif ($choice == 3) {
        print "Thanks for playing!\n";
        last;
    } else {
        print "Invalid choice, try again.\n";
    }
    
    # Update game state for next turn
    $turn++;
    $guitar_price = int(rand(50)) + 75;  # Randomize guitar price between 75 and 124
    
    if ($cash <= 0) {
        print "You've run out of cash! Game over.\n";
        last;
    }
}

