# Test composition and transitive relations using the traditional Zen lineage
clauses = @fol [
    ancestor(sakyamuni, bodhidharma) <<= true,
    teacher(bodhidharma, huike) <<= true,
    teacher(huike, sengcan) <<= true,
    teacher(sengcan, daoxin) <<= true,
    teacher(daoxin, hongren) <<= true,
    teacher(hongren, huineng) <<= true,
    ancestor(A, B) <<= teacher(A, B),
    ancestor(A, C) <<= teacher(B, C) & ancestor(A, B),
    grandteacher(A, C) <<= teacher(A, B) & teacher(B, C)
]

# Is Sakyamuni the dharma ancestor of Huineng?
goals = @fol [ancestor(sakyamuni, huineng)]
sat, subst = resolve(goals, clauses);
@test sat == true

# Who are the grandteachers of whom?
goals = @fol [grandteacher(X, Y)]
sat, subst = resolve(goals, clauses)
subst = Set(subst)
@test @folsub({X => bodhidharma, Y => sengcan}) in subst
@test @folsub({X => huike, Y => daoxin}) in subst
@test @folsub({X => sengcan, Y => hongren}) in subst
@test @folsub({X => daoxin, Y => huineng}) in subst
