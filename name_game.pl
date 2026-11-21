% Lab 9: The Name Game
:- dynamic letters/1.

letters([a, b, c]).

start :-
    writeln('Hi, This is the "Name Game".'),
    writeln('You will be given a set of English letters in which you will add, delete or move to create your name.'),
    menu.

menu :-
    nl,
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the botton'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice. : '),
    read(Choice),
    handle_choice(Choice).

handle_choice(1) :-
    letters(L),
    write('Current set of letters: '),
    writeln(L),
    menu.

handle_choice(2) :-
    write('Enter letter to add: '),
    read(Char),
    letters(L),
    append(L, [Char], NewL),
    retractall(letters(_)),
    assertz(letters(NewL)),
    writeln('Letter added.'),
    menu.

handle_choice(3) :-
    write('Enter letter to add at the top: '),
    read(Char),
    letters(L),
    NewL = [Char | L],
    retractall(letters(_)),
    assertz(letters(NewL)),
    writeln('Letter added at the top.'),
    menu.

handle_choice(4) :-
    write('Enter letter to add at the bottom: '),
    read(Char),
    letters(L),
    append(L, [Char], NewL),
    retractall(letters(_)),
    assertz(letters(NewL)),
    writeln('Letter added at the bottom.'),
    menu.

handle_choice(5) :-
    write('Enter letter to delete: '),
    read(Char),
    letters(L),
    (   select(Char, L, NewL) ->
        retractall(letters(_)),
        assertz(letters(NewL)),
        writeln('Letter deleted.')
    ;   writeln('Letter not found in the set.')
    ),
    menu.

handle_choice(6) :-
    retractall(letters(_)),
    assertz(letters([])),
    writeln('All letters deleted.'),
    menu.

handle_choice(7) :-
    writeln('Exiting Name Game. Goodbye!').

handle_choice(_) :-
    writeln('Invalid choice, please try again.'),
    menu.
