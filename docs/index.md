# MkDocs Translate

Test #5 with [release 1.3.1](https://github.com/sondregronas/mkdocs-google-translate/releases/tag/v1.3.1)

Jump to the [generated website](https://rei-vilo.github.io/MkDocs_Translate/).

Go to the issue [Incomplete generated addresses for translation #1](https://github.com/sondregronas/mkdocs-google-translate/issues/1).

## Add-on tested

[mkdocs-google-translate 1.2.0](https://pypi.org/project/mkdocs-google-translate/) and [GitHub repository](https://github.com/sondregronas/mkdocs-google-translate)

## Issue

Calling the translation from the dropdown menu opens 

`https://translate.goog/?_x_tr_sl=en&_x_tr_tl=es`  

instead of 

`https://rei--vilo-github-io.translate.goog/MkDocs_Translate/?_x_tr_sl=en&_x_tr_tl=es`

> Please find a minimal example with the [source code](https://github.com/rei-vilo/MkDocs_Translate/tree/gh-pages) and the [generated website](https://rei-vilo.github.io/MkDocs_Translate/).

HTML code in the main page includes incomplete generated addresses.

```htlm
    <div class="md-select__inner">
      <ul class="md-select__list">
        
          <li class="md-select__item">
            <a href="" hreflang="en" class="md-select__link">
              English
            </a>
          </li>
        
          <li class="md-select__item">
            <a href="https://rei-vilo-github-io.translate.goog/?_x_tr_sl=en&_x_tr_tl=es" hreflang="es" class="md-select__link">
              Español
            </a>
          </li>
        
      </ul>
    </div>
```

Two differences when processing the original address `https://rei-vilo.github.io/MkDocs_Translate/`:

    The `MkDocs_Translate/` part is missing.
    The `-` from `rei-vilo` is rendered as `-` and should be `--`.

I set the url: `https://rei-vilo.github.io/MkDocs_Translate/` option, to no avail.


How to fix this?

Thank you!
