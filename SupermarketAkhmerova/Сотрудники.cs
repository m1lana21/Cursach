//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SupermarketAkhmerova
{
    using System;
    using System.Collections.Generic;
    
    public partial class Сотрудники
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Сотрудники()
        {
            this.Продажи_товаров = new HashSet<Продажи_товаров>();
        }
    
        public int Номер_сотрудника { get; set; }
        public string Фамилия { get; set; }
        public string Имя { get; set; }
        public string Отчество { get; set; }
        public int Отдел { get; set; }
        public System.DateTime Год_рождения { get; set; }
        public System.DateTime Год_поступления_на_работу { get; set; }
        public int Должность { get; set; }
        public string Пол { get; set; }
        public string Адрес { get; set; }
        public string Город { get; set; }
        public string Телефон { get; set; }
        public Nullable<int> Стаж { get; set; }
        public string Фото_Сотрудники { get; set; }
    
        public virtual Должности Должности { get; set; }
        public virtual Отделы Отделы { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Продажи_товаров> Продажи_товаров { get; set; }
    }
}
