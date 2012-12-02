Title: Belajar Javascript: Bhg 2
Date: 2012-12-02 16:00:00
Category: JavaScript

Sebelum ini kita telah menulis kod JavaScript asas seperti berikut:-

    (function() {
        var keyword = document.getElementById('keyword');
        alert keyword;
    })();

Bagi yang biasa dengan JavaScript pasti menyedari ada masalah dengan kod di 
atas. Malah jika anda membuka fail `index.html` melalui browser, anda akan 
dapati nilai yang dipaparkan dalam `alert` adalah `null`. Ini sudah pasti bukan 
yang kita harapkan kerana nilai yang sepatutnya adalah reference kepada DOM 
object HTMLInput. Ini adalah disebabkan kod tersebut terus dijalankan apabila 
ia dibaca dalam browser. Bagaimanapun sentiasa ada kemungkinan semasa kod 
tersebut dijalankan, DOM element yang kita cuba dapatkan masih belum disediakan 
sepenuhnya oleh browser.

Untuk membetulkan masalah di atas, kita perlu attach function tersebut kepada 
`load` event sama ada pada object `window` ataupun pada element `body`. Contohnya adalah seperti berikut:-

    window.onload = function() {
        var keyword = document.getElementById('keyword');
        alert('using window.onload');
        alert (keyword);
    }

Atau:-

    function init() {
        var keyword = document.getElementById('keyword');
        alert('using body.onload');
        alert (keyword);
    }

    // dalam fail index.html
    <body onload="init()">
    </body>

Tidak ada DOM object untuk `body` dan saya pada mulanya mencuba seperti 
berikut:-

    document.body.onload = function() {
        var keyword = document.getElementById('keyword');
        alert('using document.body.onload');
        alert (keyword);
    }

tetapi mendapat error `Uncaught TypeError: Cannot set property 'onload' of 
null`. Menggunakan `body onload=init()` bagaimanapun memerlukan untuk kita 
declare satu function pada skop global, sesuatu yang kita cuba elakkan seperti 
yang telah dibincangkan dalam tulisan yang lalu. Bagi browser moden pada hari 
ini, cara yang direkomenkan adalah dengan menggunakan event listener seperti
berikut:-

    (function() {
        window.addEventListener('load', function() {
        var keyword = document.getElementById('keyword');
        alert (keyword);
        }, false);
    }());

Kelebihan cara di atas adalah struktur kod kita masih kekal sebagaimana asal 
dipermulaan siri ini. Bagaimanapun menggunakan `load` event tetap mempunyai 
satu masalah iaitu kod tersebut hanya akan dijalankan apabila kesemua elemen 
dan juga *resource* seperti imej telah selesai dimuat-turun oleh browser. Kebanyakkan kod JavaScript adalah untuk memanipulasi DOM jadi agak membuang 
masa dan juga mungkin menghasilkan kesan yang tidak diingini jika terpaksa 
menunggu kesemua *resource* selesai dimuat-turun sebelum kod JavaScript kita 
boleh memainkan peranan. Alternatif kepada `load` event adalah 
`DOMContentLoaded` dan kod di atas boleh ditulis seperti berikut:-

    (function() {
        window.addEventListener('DOMContentLoaded', function() {
        var keyword = document.getElementById('keyword');
        alert (keyword);
        }, false);
    }());

Kelebihan `DOMContentLoaded` adalah ia akan terus *execute* kod kita sebaik 
sahaja kesemua struktur DOM telah dibina dalam memori. Namun hidup dalam dunia 
JavaScript adalah sangat tidak menentu dan sukar diduga. Tidak semua browser 
menyokong event `DOMContentLoaded` ini jadi kod kita perlu melakukan beberapa 
adaptasi bagi membolehkan ia berfungsi pada semua browser. Atas sebab inilah 
library seperti JQuery menyediakan function khas untuk mengatasi masalah ini. Menggunakan JQuery, kod di atas boleh ditulis seperti berikut:-

    (function() {
        $(document).ready(function() {
            var keyword = document.getElementById('keyword');
            alert (keyword);
        });
    }());

Untuk membaca dengan lebih lanjut berkaitan isu yang dibincangkan dalam 
bahagian ini boleh rujuk perbincangan di laman stackoverflow:-

1. http://stackoverflow.com/questions/3698200/window-onload-vs-document-ready
1. 
http://stackoverflow.com/questions/3474037/window-onload-vs-body-onload-vs-document-onready

Sekian untuk kali ini, sehingga berjumpa lagi untuk siri akan datang, Insya 
Allah.
