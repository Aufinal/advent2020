class Infix:
    def __init__(self, function):
        self.function = function

    def __ror__(self, other):
        return Infix(lambda x: self.function(other, x))

    def __or__(self, other):
        return self.function(other)


p = Infix(lambda x, y: x + y)
x = Infix(lambda x, y: x * y)

with open("input-18", "r") as f:
    lines = f.readlines()
    print(sum(eval(line.replace("+", "|p|").replace("*", "|x|")) for line in lines))
    print(sum(eval(line.replace("*", "|x|")) for line in lines))
