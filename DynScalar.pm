package DynScalar;

$VERSION = '1.00';

use overload (
  '""' => sub { $_[0]->() },
  fallback => 1,
);


sub import {
  my $pkg = caller;
  my $name = (@_ == 1) ? 'dynamic' : pop;
  *{"${pkg}::$name"} = \&dynamic;
}


sub dynamic (&) { bless shift }


1;

__END__

=head1 NAME

DynScalar - closure-in-a-box for simple scalars

=head1 SYNOPSYS

  use DynScalar;  # imports as dynamic()
  use strict;
  use vars '$name';

  my $foo = dynamic { "Hello, $name!\n" };
  for $name ("Jeff", "Joe", "Jonas") { print $foo }

=head1 DESCRIPTION

This module creates closures, and masks them as objects that stringify
themselves when used.  This allows you to make incredibly simplistic string
templates:

  use DynScalar 'delay';  # import as delay()
  use strict;
  use vars qw( $name $age $sex );

  my $template = delay {
    "Hello, $name.  You're a good-looking $age-year-old $sex.\n"
  };

  while (my $rec = get_person()) {
    ($name,$age,$sex) = $rec->features;
    print $template;
  }

You can embed arbitrarily complex code in the block.

=head1 CAVEATS

You should only use package variables in the block -- lexically scoped
variables can not be seen.

=head1 AUTHOR

  Jeff "japhy" Pinyan
  CPAN ID: PINYAN
  japhy@pobox.com
  http://www.pobox.com/~japhy/

=cut

