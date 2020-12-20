from lark import Lark


def tokenize(s):
    return "".join(chr(97 + int(c)) if "0" <= c <= "9" else c for c in s)


def is_valid(parse_func, line):
    try:
        parse_func(line)
        return True
    except Exception:
        return False


with open("input-19", "r") as f:
    rules, candidates = f.read().split("\n\n")

    grammar1 = tokenize("start: 0\n" + rules)
    grammar2 = grammar1.replace(tokenize("8: 42"), tokenize("8: 42 | 42 8")).replace(
        tokenize("11: 42 31"), tokenize("11: 42 31 | 42 11 31")
    )

    parse1 = Lark(grammar1).parse
    parse2 = Lark(grammar2).parse
    print(sum(is_valid(parse1, line) for line in candidates.splitlines()))
    print(sum(is_valid(parse2, line) for line in candidates.splitlines()))
