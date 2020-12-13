import webbrowser
from urllib.parse import urlencode

with open("input-13", "r") as f:
    f.readline()
    line = f.readline()
    mods = [
        (int(x), (-i) % int(x)) for (i, x) in enumerate(line.split(",")) if x != "x"
    ]

    # x, y = list(zip(*mods))
    # s = "ChineseRemainder[{{{}}}, {{{}}}]".format(
    #     ",".join(map(str, x)), ",".join(map(str, y))
    # )

    s = ", ".join("Mod[x, {}] == {}".format(*mod) for mod in mods)
    s = "Reduce[{{{}}}, x, Integers]".format(s)
    qstr = urlencode({"i": s})
    webbrowser.open("https://www.wolframalpha.com/input/?{}".format(qstr))
