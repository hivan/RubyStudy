my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west -> :smallcave})
my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", {:east -> :largecave})