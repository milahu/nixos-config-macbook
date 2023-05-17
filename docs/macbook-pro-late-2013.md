# macbook pro late 2013

## hardware specs

https://support.apple.com/kb/SP691

- used price: between 150 and 200 eur
- wifi: broadcom
   - difficult to install on ubuntu, elementary os, ...
   - auto-detected by nixos installer, "just works"
   - external wifi adapter: smartphone with USB tethering, no need for special drivers
- no ethernet port
   - Apple Thunderbolt to Gigabit Ethernet Adapter: about 10 eur on ebay
- processor: Intel Core i5, dual core, 2 threads per core, 2.4 GHz
- graphics: integrated (intel iris)
- memory: 4 GB RAM, 1600MHz DDR3L
- storage: 128 GB SSD
   - too expensive to replace
- display: 13.3 inch, 2560x1600 px at 227 dpi (hidpi, retina display)
   - hardware bug: [apple staingate](#apple-staingate)
- USB 3.0, 2 ports
- Size and Weight
   - Height: 0.71 inch (1.8 cm)
   - Width: 12.35 inches (31.4 cm)
   - Depth: 8.62 inches (21.9 cm)
   - Weight: 3.46 pounds (1.57 kg)
- macos support: up to macos 11 (big sur)
   - macos 11 was released on 2020-11-12, so projected end-of-life (plus 3 years) is 2023-11-12

## hardware repair guides

https://www.ifixit.com/Device/MacBook_Pro_13%22_Retina_Display_Late_2013

- SSD: https://www.ifixit.com/Guide/MacBook+Pro+13-Inch+Retina+Display+Late+2013+SSD+Replacement/26811
    - "This MacBook Pro uses a proprietary storage drive connector, and is therefore not compatible with common M.2 drives without the use of an adapter."

## warranty is expired

- https://support.apple.com/en-us/HT201624
- "MacBook Pro (Retina, 13-inch, Late 2013)"
- "Service and parts may be obtained ... for up to 7 years"

## lightweight, but hard to repair

- https://www.wired.com/2012/06/opinion-apple-retina-displa/ (2012-06-14)
- The Retina MacBook is the least repairable laptop we’ve ever taken apart: Unlike the previous model, the display is fused to the glass, which means replacing the LCD requires buying an expensive display assembly. The RAM is now soldered to the logic board — making future memory upgrades impossible. And the battery is glued to the case, requiring customers to mail their laptop to Apple every so often for a $200 replacement. The design may well be comprised of “highly recyclable aluminum and glass” — but my friends in the electronics recycling industry tell me they have no way of recycling aluminum that has glass glued to it like Apple did with both this machine and the recent iPad.
- The success of the non-upgradeable Air empowered Apple to release the even-less-serviceable iPad two years later: The battery was glued into the case. And again, we voted with our wallets and purchased the device despite its built-in death clock. In the next iteration of the iPad, the glass was fused to the frame.
- Every time we buy a locked down product containing a non-replaceable battery with a finite cycle count, we’re voicing our opinion on how long our things should last. But is it an informed decision? When you buy something, how often do you really step back and ask how long it should last? If we want long-lasting products that retain their value, we have to support products that do so.

## apple staingate

over time, the display becomes unusable, because the transparent anti-glare coating becomes non-transparent

https://www.iclarified.com/47788/retina-macbook-pro-users-complain-antireflective-display-coating-is-wearing-off-photos

- Retina MacBook Pro users are complaining that the anti-reflective coating on their displays is wearing off
- The issue seems to affect mid-2012 to mid-2014 MacBook Pros sold after June 2012
- On the [Apple Support Communities](https://discussions.apple.com/thread/6068947) and [MacRumors forums](https://forums.macrumors.com/threads/mbp-retina-scratched-coating.1624907/) the issue has received over 90,000 views and 400 responses.

fix: remove the anti-glare coating with a chemical solvent

- https://www.ifixit.com/Answers/View/464586/Apple+'StainGate'+Screen+problems+-+looking+for+quick,+viable+solution
- microfiber cloth
- SMALL amount of a chemical solvent:
   - listerine (anti-bacterial mouth wash)
   - baby wipes (anti-bacterial ingredient: Octylisothiazolinone)
   - anti-bacterial wipes
   - 70% alcohol
   - 10% hydrogen peroxide
   - windex (window cleaner, glass cleaner)
   - chloride bleach
   - white vinegar (weak acid)
- do NOT use:
   - acetone: will destroy the display glass
- add new anti-glare coating
   - https://www.ebay.de/itm/385545472820
      - 2x BROTECT Matt Schutzfolie 34.29 cm (13.5 Zoll) Displays 285 x 190 mm
- german tutorials
   - https://duckduckgo.com/?q=apple+staingate+mikrofasertuch+listerine
   - https://de.ifixit.com/Anleitung/Wie+man+%22Staingate%22+auf+Apple+MacBook+Displays+entfernt/145122
