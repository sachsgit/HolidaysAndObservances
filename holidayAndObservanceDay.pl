#!/usr/bin/perl
use strict;
use warnings;
use Time::localtime;
use HTML::TreeBuilder::XPath;

my $tm = localtime;
my ( $wday, $mday, $month, $year ) = ( $tm->wday, $tm->mday, $tm->mon, $tm->year + 1900 );
my $mon = $month + 1; # Offset zero-offset
$month = (
    qw/ january   february  march
      april     may       june
      july      august    september
      october   november  december  /
)[$month];
$wday = (
    qw/ Sunday Monday Tuesday
    Wednesday Thursday Friday
    Saturday /
)[$wday];

my $date = sprintf "%02d%02d%02d", ${year}, ${mon}, ${mday};
my $url = "http://www.holidays-and-observances.com/holiday-calendar.html";
my $xpath = "//div[\@id='day-${date}']/div[1]";
my $tree = HTML::TreeBuilder->new_from_url($url);
my @entries = $tree->findvalues($xpath);

print scalar(@entries) + 1;
foreach my $entry ( @entries ) {
    print "*\t$entry\n";
}