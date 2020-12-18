from ast import parse, walk, BinOp, Mult, Sub, BitOr
import time


def mod_expr(expr, token, opclass):
    e = expr.replace("*", token)
    a = parse(e, mode="eval")
    for node in walk(a):
        if type(node) == BinOp and type(node.op) == opclass:
            node.op = Mult()

    return eval(compile(a, "", mode="eval"))


with open("input-18", "r") as f:
    lines = f.readlines()
    t = time.time()
    print(sum(mod_expr(line, "-", Sub) for line in lines))
    print(sum(mod_expr(line, "|", BitOr) for line in lines))
    print(time.time() - t)
