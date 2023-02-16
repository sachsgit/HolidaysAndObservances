#!/usr/bin/perl
use strict;
use utf8;
use warnings;
use HTML::TreeBuilder::XPath;
use Text::Unidecode;
use Time::localtime;

my $tm = localtime;
my ( $wday, $mday, $month, $year ) = ( $tm->wday, $tm->mday, $tm->mon, $tm->year + 1900 );
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

print "$wday, $mday " . capitalize($month) . " $year\n";

my $url = "http://www.holidays-and-observances.com/${month}-${mday}.html";

my $xpath = "//div[\@id='ContentColumn']/div/ul[1]/li";
my $tree = HTML::TreeBuilder->new_from_url($url);
my @entries = $tree->findvalues($xpath);
foreach my $entry ( @entries ) {
	print "*\t" . unidecode($entry) . "\n";
}

exit 0;

sub capitalize {
	my $word = shift;
	$word =~ s/([a-z])(\w+)/\u$1\L$2/;
	return $word;
}
__END__
