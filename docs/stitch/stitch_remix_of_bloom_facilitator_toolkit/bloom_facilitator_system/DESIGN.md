---
name: Bloom Facilitator System
colors:
  surface: '#fff8f8'
  surface-dim: '#e3d7d9'
  surface-bright: '#fff8f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#fdf1f2'
  surface-container: '#f7ebec'
  surface-container-high: '#f1e5e7'
  surface-container-highest: '#ebe0e1'
  on-surface: '#201a1b'
  on-surface-variant: '#514347'
  inverse-surface: '#352f30'
  inverse-on-surface: '#faeeef'
  outline: '#837377'
  outline-variant: '#d5c2c6'
  surface-tint: '#864e60'
  primary: '#411525'
  on-primary: '#ffffff'
  primary-container: '#5b2a3b'
  on-primary-container: '#d491a5'
  inverse-primary: '#fab3c7'
  secondary: '#884d5e'
  on-secondary: '#ffffff'
  secondary-container: '#fdb2c5'
  on-secondary-container: '#7a4152'
  tertiary: '#052b0b'
  on-tertiary: '#ffffff'
  tertiary-container: '#1d411f'
  on-tertiary-container: '#85ad82'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffd9e2'
  primary-fixed-dim: '#fab3c7'
  on-primary-fixed: '#360c1d'
  on-primary-fixed-variant: '#6a3748'
  secondary-fixed: '#ffd9e1'
  secondary-fixed-dim: '#fdb2c5'
  on-secondary-fixed: '#370b1b'
  on-secondary-fixed-variant: '#6c3646'
  tertiary-fixed: '#c3eebd'
  tertiary-fixed-dim: '#a7d1a3'
  on-tertiary-fixed: '#002105'
  on-tertiary-fixed-variant: '#2a4f2b'
  background: '#fff8f8'
  on-background: '#201a1b'
  surface-variant: '#ebe0e1'
typography:
  display-lg:
    fontFamily: Noto Serif
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Noto Serif
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Noto Serif
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-sm:
    fontFamily: Noto Serif
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Be Vietnam Pro
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Be Vietnam Pro
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Be Vietnam Pro
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Be Vietnam Pro
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Be Vietnam Pro
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin: 20px
  gutter: 12px
---

## Brand & Style

The design system is anchored in a "Modern Editorial Humanist" aesthetic, specifically tailored for field facilitators. It avoids the cold, sterile nature of typical SaaS platforms in favor of a warm, tactile feel reminiscent of a well-loved field guide or an NGO annual report.

The visual language evokes trust, calmness, and professional warmth. It utilizes a sophisticated "Cream and Plum" palette to ensure high legibility in various lighting conditions (including outdoor field use) while maintaining a premium, authoritative presence. The style balances minimalism with organic shapes, ensuring the UI feels approachable yet structured.

**Core Principles:**
- **Human-Centric:** Focus on legibility and ease of use in high-stress or mobile-first environments.
- **Grounded:** Uses earthy, warm tones to feel connected to the local context rather than a generic tech product.
- **Editorial:** High-contrast serif headings provide a sense of narrative and importance to the data.

## Colors

The palette is driven by a deep Burgundy/Maroon primary color, which provides the "Bloom" brand with an authoritative and grounded feel. 

- **Primary (#5B2A3B):** Used for key actions, brand moments, and primary navigation headers.
- **Secondary (#A8687A):** Used for accents, progress indicators, and softer button states.
- **Background (#ECE4D3):** A warm, parchment-like cream that reduces eye strain compared to pure white and reinforces the "field guide" aesthetic.
- **Surface (#FBF8F1):** A lighter cream used for cards and input fields to create subtle separation from the background.
- **Near-Black Plum (#3F1E29):** Used for all primary body text to ensure maximum contrast while maintaining the warm color temperature of the system.

## Typography

This design system uses a dual-font strategy to balance character with functionality.

- **Headlines (Noto Serif):** Chosen for its humanist qualities and excellent legibility. It conveys an editorial, trustworthy tone. Use "Display LG" sparingly for top-level screen titles.
- **Body & UI (Be Vietnam Pro):** A contemporary sans-serif that is warm and approachable. It handles dense information well, making it ideal for data entry and facilitator notes.

**Type Hierarchy Rules:**
- All titles should use the Serif face.
- All functional labels (buttons, inputs, navigation) must use the Sans-Serif face in Medium or SemiBold weights.
- Paragraph text should maintain a generous line height (1.5x) to improve readability in field environments.

## Layout & Spacing

The layout philosophy is centered on a flexible, mobile-first grid that prioritizes ease of interaction with a single hand (thumb-driven UI).

- **Grid Model:** A 4-column fluid grid for mobile devices with a 20px outer margin.
- **Vertical Rhythm:** A strict 4px baseline grid ensures alignment across all UI elements.
- **Safe Areas:** Strict adherence to iOS and Android safe areas, ensuring the home indicator and status bars do not overlap content.
- **Spacing Logic:** Use `lg` (24px) for spacing between logical sections and `md` (16px) for spacing between elements within a section (e.g., items in a list or fields in a form).

## Elevation & Depth

This design system avoids heavy drop shadows in favor of "Tonal Layering" and extremely soft ambient shadows.

- **Shadow Character:** Shadows should be highly diffused with a low opacity (maximum 8%) and tinted with the Primary color (#5B2A3B) rather than pure black. This maintains the warmth of the palette.
- **Levels:**
  - **Level 0 (Base):** The Warm Cream background (#ECE4D3).
  - **Level 1 (Cards):** Light Cream (#FBF8F1) with a 1px stroke of the background color or a very soft 4px blur shadow.
  - **Level 2 (Modals/Overlays):** Light Cream with a 12px blur shadow, used for bottom sheets and action menus.
- **Interactions:** When a user interacts with a card, it should not "lift" significantly; instead, use a subtle tonal shift or a 1px border of the Secondary color.

## Shapes

The shape language is "Softly Organic." To reinforce the approachable and humanist brand, the system uses generous corner radii.

- **Buttons & Inputs:** Use the `rounded-lg` (16px) setting for a friendly, modern feel.
- **Cards & Large Containers:** Use `rounded-xl` (24px) to create a soft, welcoming container for content.
- **Chips:** Always use full pill-shaping (circular ends) for categorical tags to distinguish them from actionable buttons.

## Components

**Buttons:**
- **Primary:** Solid #5B2A3B with white or cream text. 16px corner radius. High-height (48px-56px) for easy tapping in mobile environments.
- **Secondary:** Outline style with 1.5px stroke of #A8687A.
- **Ghost:** Text-only, using the Secondary color, for less important actions.

**Cards:**
- Cards should use the Surface color (#FBF8F1). 
- Avoid borders where possible; use the subtle ambient shadow to define the edge against the Background color.

**Input Fields:**
- Background should be Surface color. 
- Bottom-aligned labels or floating labels are preferred to save vertical space.
- Focused state uses a 2px bottom border of the Primary color.

**Lists:**
- Use generous vertical padding (16px) between list items.
- Separators should be subtle: 1px height using #5B2A3B at 10% opacity.

**Status Bar & Home Indicator:**
- The status bar should use dark icons (Near-Black Plum) to contrast against the Warm Cream background. 
- Ensure a minimum of 44px bottom padding to clear the iOS home indicator.