from lark import Lark, Transformer, v_args
import time

grammar1 = """
    ?start: expr

    ?expr: atom
        | expr "+" atom  -> add
        | expr "*" atom  -> mul

    ?atom: INT           -> number
        | "(" expr ")"


    %import common.INT
    %import common.WS
    %ignore WS
"""

grammar2 = """
    ?start: product

    ?product: sum
        | product "*" sum   -> mul

    ?sum: atom
        | sum "+" atom  -> add

    ?atom: INT           -> number
         | "(" product ")"

    %import common.INT
    %import common.WS
    %ignore WS
"""


@v_args(inline=True)
class CalcTree(Transformer):
    from operator import add, mul

    number = int


parser1 = Lark(grammar1, parser="lalr", transformer=CalcTree())
parser2 = Lark(grammar2, parser="lalr", transformer=CalcTree())
calc1 = parser1.parse
calc2 = parser2.parse

with open("input-18", "r") as f:
    lines = f.readlines()
    t = time.time()
    print(sum(calc1(expr) for expr in lines))
    print(sum(calc2(expr) for expr in lines))
    print(time.time() - t)
