
# ref https://github.com/jaagr/polybar/wiki/Fonts
# Usage: perl test-fonts.pl "😀"
# NOTE: need to install module
# $ perl -MCPAN -e 'install Font::FreeType'

use strict;
use warnings;
use Font::FreeType;
my ($char) = @ARGV;
foreach my $font_def (`fc-list`) {
    my ($file, $name) = split(/: /, $font_def);
    my $face = Font::FreeType->new->face($file);
    my $glyph = $face->glyph_from_char($char);
    if ($glyph) {
        print $font_def;
    }
}
