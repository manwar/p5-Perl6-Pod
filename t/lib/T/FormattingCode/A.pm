#===============================================================================
#
#  DESCRIPTION:  Test A
#
#       AUTHOR:  Aliaksandr P. Zahatski, <zahatski@gmail.com>
#===============================================================================
package T::FormattingCode::A;
use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Perl6::Pod::To::XHTML;
use XML::ExtOn('create_pipe');
use base 'TBase';

sub t01_as_xml : Test(2) {
    my $t = shift;
    my $x = $t->parse_to_xml( <<T);
=alias TEST Test1
=para
Bold A<TEST>
T
    ok $x =~/Test1/, 'Check replaced text';
    $t->is_deeply_xml(
        $x,
q#<para pod:type='block' xmlns:pod='http://perlcabal.org/syn/S26.html'>Bold Test1
</para>#
    );
}

sub t02_as_xhtml : Test {
    my $t = shift;
    my $x = $t->parse_to_xhtml( <<T);
=alias TEST B<Test1>
=para
Bold A<TEST>
T
    $t->is_deeply_xml(
        $x,
q#<xhtml xmlns='http://www.w3.org/1999/xhtml'><p>Bold <strong>Test1</strong>
</p></xhtml>#
    );
}

sub t03_as_docbook : Test {
    my $t = shift;
    my $x = $t->parse_to_docbook( <<T);
=alias TEST B<Test1> 
=para
Bold A<TEST>
T
 $t->is_deeply_xml(
        $x,
q#<chapter><para>Bold <emphasis role='bold'>Test1</emphasis> 
</para></chapter>#)
}

1;


