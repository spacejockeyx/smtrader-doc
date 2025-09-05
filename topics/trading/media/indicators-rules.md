# Indicators and Rules Strategy

You're right. keeping your "informational" rules separate from standard "indicators" is an excellent architectural decision. they are a distinct middle layer between raw indicators and final action rules.

your instinct is correct—they are your subjective logic, but they serve a different purpose than a simple indicator like an sma.

***
## The three layers of strategy logic

thinking of your strategy in three distinct layers is a very robust and clear way to design it.

### 1. market indicators (the "what")

these are pure, objective calculations based on market data (price/volume). they have no knowledge of your position, budget, or intent.
* **examples**: sma, rsi, bollinger bands, price slope.
* **purpose**: to describe the raw state of the market.
* **analogy**: these are the **vital signs** a doctor takes from a patient (temperature, blood pressure). they are raw, objective data. 🩺

### 2. informational rules (the "so what?")

this is your new category. these rules take the raw indicators and add your **personal context** (your position, your bep, your risk tolerance) to create meaningful, subjective metrics.
* **examples**: "calculate my current bep," "is the price currently above my bep?", "calculate the risk/reward ratio for a trade at this price."
* **purpose**: to interpret market data in the context of your specific situation.
* **analogy**: these are the **lab results** a doctor orders based on the vital signs. they provide deeper, contextual insights (e.g., cholesterol levels, blood cell count).

### 3. action rules (the "now what?")

these are the final decision-makers. they take the outputs from both indicators and informational rules to generate a final `buy`, `sell`, or `hold` signal.
* **examples**: "if the sma is rising and the price is above my bep, then buy," "if the risk/reward ratio is below 2:1, do not trade."
* **purpose**: to make a final, actionable trading decision.
* **analogy**: this is the **doctor's diagnosis and prescription**. based on the vitals and lab results, the doctor makes a final decision. 💊

## conclusion

your idea to see them as separate is a sign of a well-structured design. it creates a clear flow of logic: raw market data is turned into **indicators**, which are then interpreted by **informational rules** to create personal context, which is finally used by **action rules** to make a decision.

this separation makes your strategy easier to build, test, and debug.