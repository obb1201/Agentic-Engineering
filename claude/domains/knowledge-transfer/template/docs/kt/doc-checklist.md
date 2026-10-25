# Doc Checklist

A document is done only when every item is checked. The `doc-reviewer` subagent works through this list.

## Accuracy

- [ ] Every bullet, step and table row has a citation, and the citation hook passes.
- [ ] Spot-checked citations say what the document claims.
- [ ] No guess words: "probably", "seems", "likely", "should".
- [ ] Anything unconfirmed is in `open-questions.md`, not in the document.

## Safe to share

- [ ] No secrets. Only where they are kept.
- [ ] No commercial information: rates, costs, staffing, contract terms.
- [ ] Nothing about other clients.
- [ ] None of the out-of-scope items listed in `CLAUDE.md`.

## Useful to the receiver

- [ ] Written for a developer who knows the stack but not this system.
- [ ] Steps use exact names, commands and screens, in order, and say how to check they worked.
- [ ] Each known issue has a symptom, cause, workaround and permanent fix (or "not known").
- [ ] Under 300 lines, and follows its template.
- [ ] Terms match `glossary.md`.

## Tested

- [ ] The `cold-reader` answered every test question for this document, or each gap has a fix or an open question.

## Records

- [ ] Status, cold-reader result and human interventions are updated in `outline.md`.
- [ ] New decisions are in `decision-log.md`.
