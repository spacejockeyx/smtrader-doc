# StrategyRunner and OrderManager Design Decision

## Question

> **I will execute one StrategyRunner instance for every StockSymbol, so there will be multiple StrategyRunners at the same time running.
> For managing the orders, should I run a general OrderManager application for all orders created by all StrategyRunners (for all StockSymbols) or should I create a dedicated OrderManager instance for each StrategyRunner (based on StockSymbol)?**

## Answer

### Options Comparison

#### Option 1: One Centralized OrderManager for All StrategyRunners

| Pros                                                                      | Cons                                                                                                  |
| :------------------------------------------------------------------------ | :---------------------------------------------------------------------------------------------------- |
| Easier to **control**, **monitor**, and **debug**.                        | Risk of **single bottleneck** — all StrategyRunners depend on it.                                     |
| Simplifies managing things like **risk control** across symbols.          | If it **crashes**, **all** your strategies are blocked.                                               |
| Easier to implement **global order validation** (e.g., limit total risk). | You may need to carefully synchronize concurrent orders from multiple strategies (more complex code). |
| Easier when you want a **global view** (all orders at once).              | Scaling can be trickier later if trading gets huge.                                                   |

---

#### Option 2: Dedicated OrderManager Per StrategyRunner (Per StockSymbol)

| Pros                                                                 | Cons                                                                                   |
| :------------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| Completely **isolated** — failure of one does **not** affect others. | Harder to **coordinate risk globally** (if needed).                                    |
| More **scalable** — each strategy runs fully independently.          | Slightly more **overhead**: more processes, more resource use.                         |
| Easier for **horizontal scaling** (cloud, clusters).                 | Harder to **see full portfolio** at once without aggregation.                          |
| Matches a **microservice** philosophy better.                        | Need an extra layer to **aggregate** orders across symbols if you want portfolio view. |

---

### 🌟 Recommendation

Since you are planning:

* **One StrategyRunner per StockSymbol**
* **Running inside Kubernetes clusters**
* **Focusing on modularity and scalability**

✅ **It is strongly recommended to have a dedicated OrderManager instance per StrategyRunner.**

#### Benefits

* Clean and modular system.
* No cross-dependency between different stock strategies.
* Easy to restart or replace individual components.
* Natural scaling with Kubernetes.
* Matches microservice best practices.

---

### Visual Representation

```text
StrategyRunner (AAPL) → OrderManager (AAPL)
StrategyRunner (TSLA) → OrderManager (TSLA)
StrategyRunner (AMZN) → OrderManager (AMZN)
...
```

* Central Node (Orchestrator) aggregates if needed.

---

### Bonus Tip

Later, for full **portfolio-level risk management**,
you can build a **Risk Manager service** that coordinates everything at the Central Node level.

---

# Conclusion

> ➔ **Create one OrderManager instance inside or alongside each StrategyRunner container, scoped only for that symbol.**

This approach gives **maximum modularity, maximum fault tolerance, and future-proof scaling**.
